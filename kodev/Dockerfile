FROM alpine:latest

MAINTAINER Joris Vink <joris@coders.se>

ADD https://git.kore.io/kore.git/refs/heads/master master.commit

RUN set -e && \
  apk add --no-cache --virtual .build-deps \
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
  rm -rf kore*

COPY entry.sh /

EXPOSE 80 443 8888

ENTRYPOINT ["/entry.sh"]
