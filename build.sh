#!/bin/sh

if [ $# -ne 1 ]; then
	echo "Usage: build.sh <dir>"
	exit 1
fi

IMAGE=$1

set -e

docker build -t kore/kore:$IMAGE-amd64 --platform linux/amd64 $IMAGE
docker push kore/kore:$IMAGE-amd64

docker build -t kore/kore:$IMAGE-arm64 $IMAGE
docker push kore/kore:$IMAGE-arm64

docker manifest rm kore/kore:$IMAGE

docker manifest create kore/kore:$IMAGE \
  --amend kore/kore:$IMAGE-arm64 \
  --amend kore/kore:$IMAGE-amd64

docker manifest push kore/kore:$IMAGE
