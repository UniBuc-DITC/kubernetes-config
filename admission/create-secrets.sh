#!/usr/bin/env bash

set -e

echo Rails master key:
read RAILS_MASTER_KEY

kubectl -n admission-app create secret generic admitere-staging.master-key \
    --from-literal="key=$RAILS_MASTER_KEY"

echo Initial admin account e-mail:
read ADMIN_EMAIL

echo Initial admin account password:
read ADMIN_PASSWORD

kubectl -n admission-app create secret generic admitere-staging.admin-credentials \
    --from-literal="email=$ADMIN_EMAIL" \
    --from-literal="password=$ADMIN_PASSWORD"
