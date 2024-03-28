#!/usr/bin/env bash

set -e

echo Username for GitLab Docker Registry access:
read DOCKER_USERNAME

echo Password/token for GitLab Docker Registry access:
read DOCKER_PASSWORD

kubectl create secret docker-registry -n admission-app admission-docker-registry-pull-secret \
    --docker-server=https://registry.gitlab.com \
    --docker-username="$DOCKER_USERNAME" \
    --docker-password="$DOCKER_PASSWORD"
