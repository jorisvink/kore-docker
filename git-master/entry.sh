#!/bin/sh

set -e

PATH=$PATH:/usr/local/bin

mkdir -p /var/chroot/acme/etc
mkdir -p /var/chroot/acme/etc/ssl/certs/

cp /etc/resolv.conf /var/chroot/acme/etc
cp /etc/ssl/certs/ca-certificates.crt /var/chroot/acme/etc/ssl/certs/

exec kore $@
