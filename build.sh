#!/usr/bin/env bash

set -euo pipefail

DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $DIRNAME > /dev/null

REPO=${1:?"Choose the name of the repository. Example: ${0} johnsmith/dbapi"}
TAG=${2:-"$(date --utc +%Y%m%d%H%M%S)"}

docker build . --no-cache -t "${REPO}:${TAG}"
docker push "${REPO}:${TAG}"

popd > /dev/null
