Official kore docker images.

## Using base images to create a custom Docker container

```
FROM kore/kore:4.1.0

WORKDIR /koreapp
COPY *.py .

EXPOSE 8888
CMD ["app.py"]
```

## Using the base image to run an application

```
$ docker run -p 8888:8888 -it --rm \
    -v `pwd`/code:/app \
    -w /app kore/kore:4.1.0 /app/app.py
```

## Using the kodev docker image

You can use the kodev docker image to build your application.

While doing so it is important you set the workdir to the name
of your application so kodev build will correctly pickup the
configuration.

The kore/kodev container has 2 tags, amd64 and arm64.

Building an application:

```
$ docker run -it --rm \
    -v `pwd`:/myapp \
    -w /myapp kore/kodev:arm64 build
```

## ACME

The docker images support ACME. If you are going to enable it
you probably want to use a volume of sorts to store the account
key and certificates on persistent storage.

The keymgr will store all relevant data under the **/var/chroot/keymgr**
path. You can use a volume to export that directory to your host instead.

```
$ docker run -p 8888:8888 -it --rm \
    -v `pwd`/code:/app \
    -v `pwd`/keymgr:/var/chroot/keymgr \
    -w /app kore/kore:4.1.0 /app/app.py
```

## Deployment target

When using Python, you should set the deployment target to "docker".
This will keep Kore in the foreground but still apply privilege separation.

```python
kore.config.deployment = "docker"
```

## Users and paths

The docker images provide users for all privilege separated processes.

These users are:

### kore

The kore user its homedir is located under **/var/chroot/kore** and is
intended to be the main user for the worker processes.

### Default configuration

runas kore
root /var/chroot/kore

### Python configuration

```python
kore.config.runas = "kore"
kore.config.root = "/var/chroot/kore"
```

## acme

The acme user its homedir is located under **/var/chroot/acme** and
is intended to be the main ACME process user.

The acme process is the process that talks to the ACME servers and
parsers their responses.

### Default configuration

acme_runas acme
acme_root /var/chroot/acme

### Python configuration

```python
kore.config.acme_runas = "acme"
kore.config.acmer_root = "/var/chroot/acme"
```

## keymgr

The keymgr user its homedir is located under **/var/chroot/keymgr**
and is intended to be the keymgr process user.

The keymgr process holds all your private keys.

### Default configuration

keymgr_runas keymgr
keymgr_root /var/chroot/keymgr

### Python configuration

```python
kore.config.keymgr_runas = "keymgr"
kore.config.keymgr_root = "/var/chroot/keymgr"
```
