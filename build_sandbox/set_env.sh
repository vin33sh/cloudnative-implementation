#!/bin/sh

#In CICD pipelines these should be set from the secret vault
export DB_ROOT_PASS=root-pass
export DB_USER=myappuser
export DB_PASS=myapppass
export DB_NAME=test
export DATABASE_HOST=mongodb
export DB_CONNECTION=mongodb://${DB_USER}:${DB_PASS}@${DATABASE_HOST}:27017/${DB_NAME}
export IMAGE_REPOSITORY_API=mykubedemo.azurecr.io/go-to-do-api
export IMAGE_REPOSITORY_CLIENT=mykubedemo.azurecr.io/go-to-do-frontend
export KUBE_MIGRATE_HOSTNAME=<valid-host-name>.cloudapp.azure.com
