# Kubernetes node setup

This document describes the steps which have to be taken when preparing a new node to be added to the Kubernetes cluster.

For simplicity and consistency, all of our Kubernetes machines should run the latest LTS version of [Ubuntu Server](https://ubuntu.com/), with all updates installed.

## Swap space configuration

As [recommended by Kubernetes best practices](https://serverfault.com/a/881518/957097), we [disable swap](https://askubuntu.com/questions/214805/how-do-i-disable-swap) and remove the swap file on all machines which also run pods, to ensure consistent performance.

## Install RKE2

We use Rancher's [RKE2](https://docs.rke2.io/) Kubernetes distribution.

The latest _stable_ version of RKE2 can be installed on a Linux machine by running:

```bash
curl -sfL https://get.rke2.io | sh -
```

<!-- TODO: need to double-check this. How does NAT affect these rules?
## Firewall configuration

We will use the [Uncomplicated Firewall (UFW)](https://wiki.ubuntu.com/UncomplicatedFirewall) for network protection. It has to be [configured](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04) to allow communication between the node's control planes.

The full list of ports which the default install of RKE2 uses is available [here](https://docs.rke2.io/install/requirements#inbound-network-rules). For our purposes it's enough to allow all communications on the specified ports, as long as the source IP is on the internal UB network:

```sh
ufw allow from 10.0.0.0/8 proto tcp to any port 2379
ufw allow from 10.0.0.0/8 proto tcp to any port 2380
ufw allow from 10.0.0.0/8 proto tcp to any port 2381

ufw allow from 10.0.0.0/8 proto tcp to any port 6443
ufw allow from 10.0.0.0/8 proto tcp to any port 9345
ufw allow from 10.0.0.0/8 proto tcp to any port 10250

```
-->

<!-- TODO: need to update this for RKE2
### Azure AD authentication

To allow the Kubernetes API server to validate access tokens issued by Azure AD, the API server daemon needs to be configured with the following additional parameters:

```sh
# Enable authentication with Azure AD
--oidc-issuer-url=https://sts.windows.net/08a1a72f-fecd-4dae-8cec-471a2fb7c2f1/
--oidc-client-id=da028dbe-ac85-4fbf-9288-0f8353bfa757
--oidc-username-claim=sub
--oidc-username-prefix=azuread:
--oidc-groups-claim=roles
--oidc-groups-prefix=azuread:
```

These have been added in the `/var/snap/microk8s/current/args/kube-apiserver` file, as indicated by the Microk8s documentation on [how to configure the internal K8s services](https://microk8s.io/docs/configuring-services).
-->
