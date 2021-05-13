# Kubernetes configuration files

According to the Kubernetes [Configuration Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/#general-configuration-tips), config files should be versioned controlled before being deployed. This simplifies rolling back config changes and provides greater transparency into the cluster's organisation.

This repository contains the generic, cluster-wide configuration settings. Project-specific config files are in their respective repositories.

## Existing setup

UniBuc runs its Kubernetes cluster using [Microk8s](https://microk8s.io/) on the existing virtual machine-based infrastructure.

## Enabled K8s plugins

- [Role-Based Access Control](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Kubernetes Dashboard](https://github.com/kubernetes/dashboard)
- [Metrics Server](https://github.com/kubernetes-sigs/metrics-server)
- [CoreDNS](https://coredns.io/)
- [NGINX Ingress Controller](https://github.com/kubernetes/ingress-nginx)
