#!/bin/bash


### Clean up
rm -rf ./to-do-kubemigrate-master

### Download src code from github.com
curl -O -L https://github.com/vin33sh/to-do-kubemigrate/archive/refs/heads/master.zip

#unzip
unzip master.zip
rm master.zip

#Delete old local docker images
docker image inspect abdennour/go-to-do-frontend:rc >/dev/null 2>&1 && docker rmi abdennour/go-to-do-frontend:rc || echo 'abdennour/go-to-do-frontend:rc not present locally'
docker image inspect abdennour/go-to-do-api:rc >/dev/null 2>&1 && docker rmi abdennour/go-to-do-api:rc || echo 'abdennour/go-to-do-api:rc not present locally'
docker image inspect mykubedemo.azurecr.io/go-to-do-frontend:latest >/dev/null 2>&1 && docker rmi mykubedemo.azurecr.io/go-to-do-frontend:latest || echo 'mykubedemo.azurecr.io/go-to-do-frontend not present locally'
docker image inspect mykubedemo.azurecr.io/go-to-do-api:latest >/dev/null 2>&1 && docker rmi mykubedemo.azurecr.io/go-to-do-api:latest || echo 'mykubedemo.azurecr.io/go-to-do-api not present locally'

#Build docker images
docker-compose -f ./to-do-kubemigrate-master/docker-compose.yaml build

#Prune dangling images
docker image prune -f

#Tag newly built images to my ACR
docker tag abdennour/go-to-do-frontend:rc mykubedemo.azurecr.io/go-to-do-frontend
docker tag abdennour/go-to-do-api:rc mykubedemo.azurecr.io/go-to-do-api

#Push to ACR (assumes docker is lined to ACR)
docker push mykubedemo.azurecr.io/go-to-do-frontend
docker push mykubedemo.azurecr.io/go-to-do-api
