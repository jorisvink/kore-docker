FROM alpine:latest

MAINTAINER Joris Vink <joris@coders.se>

RUN apk add --no-cache \
  curl \
  libpq \
  python3

RUN addgroup -g 500 keymgr && \
  adduser -D -u 500 -h /var/chroot/keymgr -s /sbin/nologin -G keymgr keymgr && \
  addgroup -g 501 acme && \
  adduser -D -u 501 -h /var/chroot/acme -s /sbin/nologin -G acme acme && \
  addgroup -g 502 kore && \
  adduser -D -u 502 -h /var/chroot/kore -s /sbin/nologin -G kore kore

ADD https://git.kore.io/kore.git/refs/heads/master master.commit

RUN apk add --no-cache --virtual .build-deps \
  musl-dev \
  linux-headers \
  bsd-compat-headers \
  gcc \
  make \
  openssl-dev \
  postgresql-dev \
  pkgconfig \
  libcurl \
  curl-dev \
  libpq \
  git \
  python3-dev && \
  git clone https://git.kore.io/kore.git && \
  cd kore && \
  make clean && \
  make PYTHON=1 ACME=1 CURL=1 PGSQL=1 && \
  make install && \
  cd .. && \
  rm -rf kore* && \
  apk del .build-deps

EXPOSE 443 8888
ENTRYPOINT [ "kore" ]
