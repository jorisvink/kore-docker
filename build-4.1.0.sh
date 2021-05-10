#!/bin/sh

set -e

docker build -t kore/kore:4.1.0-amd64 --platform linux/amd64 4.1.0
docker push kore/kore:4.1.0-amd64

docker build -t kore/kore:4.1.0-arm64 4.1.0
docker push kore/kore:4.1.0-arm64

docker manifest rm kore/kore:4.1.0

docker manifest create kore/kore:4.1.0 \
  --amend kore/kore:4.1.0-arm64 \
  --amend kore/kore:4.1.0-amd64

docker manifest push kore/kore:4.1.0
