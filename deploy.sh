#!/usr/bin/env bash

set -euo pipefail

DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $DIRNAME > /dev/null

KIND_CONFIG=${KIND_CONFIG:-"kind-config.yaml"}
PROJECT=${PROJECT:-"interview-test"}

MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"test"}
MYSQL_DATABASE=${MYSQL_DATABASE:-"test"}
MYSQL_USER=${MYSQL_USER:-"test"}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-"test"}

echo  -e "\nCreating kind cluster with three workers"
kind create cluster --name $PROJECT --config $KIND_CONFIG

kubectl config set-context kind-$PROJECT
kubectl create namespace $PROJECT

echo  -e "\nCreating secret"
kubectl create secret generic my-db-secret \
    --from-literal=MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
    --from-literal=MYSQL_DATABASE=$MYSQL_DATABASE \
    --from-literal=MYSQL_USER=$MYSQL_USER \
    --from-literal=MYSQL_PASSWORD=$MYSQL_PASSWORD \
     -n $PROJECT

echo -e "\nDeploying database"
kubectl apply -f yamls/myDatabase.yaml
kubectl wait pods -n $PROJECT -l app="my-database" --for condition=Ready
echo -e "\nWaiting for the database to be ready"; sleep 10s

echo -e "\nDeploying api"
kubectl apply -f yamls/myApi.yaml
kubectl wait pods -n $PROJECT -l app="my-api" --for condition=Ready
echo  -e "\nWaiting for the api to be ready"; sleep 40s

echo  -e "\nCheck the api at http://localhost:3000/posts"
kubectl port-forward service/my-api 3000:3000 -n $PROJECT

popd > /dev/null
