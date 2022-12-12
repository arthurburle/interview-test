## Requirements
  * [Kind - v0.14.0](https://github.com/kubernetes-sigs/kind/tree/v0.14.0)
  * [Docker](https://docs.docker.com/engine/install/)
  * [Kubectl](https://kubernetes.io/docs/tasks/tools/)

## Building Image

```bash
./build.sh REPO TAG
```
Where:
  * `REPO`: Refers to the container repository this image will be pushed to.
  * `TAG`: Tag of the image. | Default `current date and time (UTC)`

## Deploying Application

```bash
./deploy.sh
```

Where these env vars can be replaced:
  * `KIND_CONFIG`: Kind config file. | Default `kind-config.yaml`
  * `PROJECT`: Name of the project. | Default `interview-test`
  * MYSQL env vars:
    * `MYSQL_ROOT_PASSWORD`: | Default `test`
    * `MYSQL_DATABASE`: | Default `test`
    * `MYSQL_USER`: | Default `test`
    * `MYSQL_PASSWORD`: | Default `test`
