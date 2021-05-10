#!/bin/sh

set -e

docker build -t kore/kore:git-master-amd64 --platform linux/amd64 git-master
docker push kore/kore:git-master-amd64

docker build -t kore/kore:git-master-arm64 git-master
docker push kore/kore:git-master-arm64

docker manifest rm kore/kore:git-master

docker manifest create kore/kore:git-master \
  --amend kore/kore:git-master-arm64 \
  --amend kore/kore:git-master-amd64

docker manifest push kore/kore:git-master
