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
