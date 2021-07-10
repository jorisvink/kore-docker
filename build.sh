#!/bin/sh

set -e

if [ $# -ne 1 ]; then
	echo "Usage: build.sh <dir>"
	exit 1
fi

IMAGE=$1
REPO=kore

if [ "$IMAGE" = "kodev" ]; then
	REPO=kodev
fi

docker build -t kore/$REPO:$IMAGE-amd64 --platform linux/amd64 $IMAGE
docker push kore/$REPO:$IMAGE-amd64

docker build -t kore/$REPO:$IMAGE-arm64 $IMAGE
docker push kore/$REPO:$IMAGE-arm64

docker manifest rm kore/$REPO:$IMAGE

docker manifest create kore/$REPO:$IMAGE \
  --amend kore/$REPO:$IMAGE-arm64 \
  --amend kore/$REPO:$IMAGE-amd64

docker manifest push kore/$REPO:$IMAGE
