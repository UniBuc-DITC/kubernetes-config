# Kubernetes configuration files

According to the Kubernetes [Configuration Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/#general-configuration-tips), config files should be versioned controlled before being deployed. This simplifies rolling back config changes and provides greater transparency into the cluster's organisation.

This repository contains the generic, cluster-wide configuration settings. Project-specific config files are in their respective repositories.

## Existing setup

UniBuc runs its Kubernetes cluster using [Microk8s](https://microk8s.io/) on the existing virtual machine-based infrastructure.

## Recommended tools

- [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) for cluster administration
- [Helm](https://helm.sh/) for easy package installation

## Enabled K8s plugins

- [Role-Based Access Control](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Metrics Server](https://github.com/kubernetes-sigs/metrics-server)
- [CoreDNS](https://coredns.io/)

## Additional controllers

- [NGINX Ingress Controller](https://github.com/kubernetes/ingress-nginx)
- [cert-manager](https://cert-manager.io/) for automatic TLS certificate management

## Admin site

IT admins can access everything they need at https://kubernetes.unibuc.ro/

Authentication is available through the MS365 accounts. The Kubernetes API server is configured to accept [OpenID Connect Tokens](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#openid-connect-tokens) issued by Azure AD.

- [oauth2-proxy](https://github.com/oauth2-proxy/oauth2-proxy) is used to protect the admin site
- [Kubernetes Dashboard](https://github.com/kubernetes/dashboard) is accessible at https://kubernetes.unibuc.ro/dashboard/
