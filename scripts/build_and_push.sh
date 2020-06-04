#!/bin/sh

DOCKER_ORG=${DOCKER_ORG:-hatappi}

if [[ -z "${TARGET}" ]]; then
  echo 'Please speicfy `TARGET`'
  exit 1
fi

ROOT_DIR=$(cd $(dirname $0); pwd)/..
TARGET_DIR=${ROOT_DIR}/${TARGET}
META_JSON=${TARGET_DIR}/meta.json

TAG=$(cat ${META_JSON} | jq -r '.tag')
NAME=$(cat ${META_JSON} | jq -r '.name')

if [[ -z "${TAG}" ]]; then
  echo ".tag not found in ${META_JSON}"
  exit 1
fi

if [[ -z "${NAME}" ]]; then
  echo ".name not found in ${META_JSON}"
  exit 1
fi

IMAGE_NAME="${DOCKER_ORG}/${NAME}"

docker build \
  -t ${IMAGE_NAME}:${TAG} \
  -f ${TARGET_DIR}/Dockerfile \
  .

if [ -z "$ONLY_BUILD" ]; then
  echo docker push ${IMAGE_NAME}:${TAG}
fi
