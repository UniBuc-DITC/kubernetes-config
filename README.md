# Kubernetes configuration files

This repository contains the general configuration files for the University of Bucharest's [Kubernetes](https://kubernetes.io/) cluster. We only keep global, cluster-wide config files here; project-specific configs are in their respective repositories.

According to the Kubernetes [Configuration Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/#general-configuration-tips), config files should be versioned controlled before being deployed. This simplifies rolling back config changes and provides greater transparency into the cluster's organisation.

## Existing setup

UniBuc runs its Kubernetes cluster using [RKE2](https://docs.rke2.io/) on the existing virtual machine-based infrastructure. See the [node setup documentation](SETUP.md) for information on how the individual nodes are configured.

## Recommended tools

You should install the tools below if you plan to manage/work with K8s.

- [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) for cluster administration
  - Follow the instructions on [this page](https://kubernetes.io/docs/tasks/tools/) for installing `kubectl` on your platform.
- [kubelogin](https://github.com/Azure/kubelogin) for AAD authentication
  - You can use a [binary release](https://github.com/Azure/kubelogin/releases), for example.
  - Adapt the [sample Kubeconfig file](kubeconfig) to your needs. You can either put it in the `$HOME/.kube/` directory
  - Upon first connecting to the cluster, the tool will ask you to open a link in the browser and log into MS365.
- [Helm](https://helm.sh/) for easy package installation
- [Cilium CLI](https://github.com/cilium/cilium-cli) if you need to manage Cilium

## Enabled K8s plugins

- [Role-Based Access Control](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Metrics Server](https://github.com/kubernetes-sigs/metrics-server)
- [CoreDNS](https://coredns.io/)

## Additional controllers and operators

- [NGINX Ingress Controller](https://github.com/kubernetes/ingress-nginx)
- [cert-manager](https://cert-manager.io/) for automatic TLS certificate management
- [Kubernetes secret generator](https://github.com/mittwald/kubernetes-secret-generator)

## Admin site

IT admins can access everything they need at https://kubernetes.unibuc.ro/

Authentication is available through the MS365 accounts. The Kubernetes API server is configured to accept [OpenID Connect Tokens](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#openid-connect-tokens) issued by Azure AD. The user's groups are configured through [Azure AD app roles](https://docs.microsoft.com/en-us/azure/architecture/multitenant-identity/app-roles).

- [oauth2-proxy](https://github.com/oauth2-proxy/oauth2-proxy) is used to protect the admin site
- [Kubernetes Dashboard](https://github.com/kubernetes/dashboard) is accessible at https://kubernetes.unibuc.ro/dashboard/
- [kubeapps](https://kubeapps.com/) is accessible at https://kubernetes.unibuc.ro/apps/
