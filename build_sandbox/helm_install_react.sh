#!/bin/sh


helm uninstall sample-app-react || exit_code=$?

cd ./to-do-kubemigrate-master/helm-charts/to-do-frontend/

helm install --set image.repository=$IMAGE_REPOSITORY_CLIENT --set ingress.hosts[0].host=$KUBE_MIGRATE_HOSTNAME -f values.yaml sample-app-react .
