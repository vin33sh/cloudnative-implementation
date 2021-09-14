#!/bin/sh

helm uninstall sample-app-go || exit_code=$?

cd ./to-do-kubemigrate-master/helm-charts/to-do-api/

helm install --set DB_CONNECTION=$DB_CONNECTION --set DB_NAME=$DB_NAME --set image.repository=$IMAGE_REPOSITORY_API --set ingress.hosts[0].host=$KUBE_MIGRATE_HOSTNAME -f values.yaml sample-app-go .
