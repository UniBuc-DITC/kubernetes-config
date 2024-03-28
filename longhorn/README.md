# Longhorn

[Longhorn](https://longhorn.io/) is a distributed storage engine for stateful Kubernetes workloads. It is able to use the existing nodes' storage in an efficient way, which is helpful when trying to set up an on-prem K8s cluster.

## Securing Longhorn UI using basic auth

The Longhorn UI ingress is secured using HTTP basic auth. For it to work, it must have a `basic-auth` secret in the `longhorn-system` namespace.

Create a properly encrypted password file by running:

```sh
USER='<username>'; PASSWORD='<password>'; echo "${USER}:$(openssl passwd -stdin -apr1 <<< ${PASSWORD})" >> auth
```

Then create the secret using:

```sh
kubectl -n longhorn-system create secret generic basic-auth --from-file=auth
```

It is imperative that the credentials file is named `auth`, to ensure the generated secret will have the right structure.
