# Kubernetes node setup

This document describes the steps which have to be taken when preparing a new node to be added to the Kubernetes cluster.

For simplicity and consistency, all of our Kubernetes machines should run the latest LTS version of [Ubuntu Server](https://ubuntu.com/), with all updates installed.

## Firewall configuration

We will use the [Uncomplicated Firewall (UFW)](https://wiki.ubuntu.com/UncomplicatedFirewall) for network protection. It has to be [configured](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04) to allow communication between the node's control planes.

The full list of ports which Microk8s uses are available [here](https://microk8s.io/docs/services-and-ports). For our purposes it's enough to allow communication on the following two ports for all machines on the internal UB network:

```sh
ufw allow from 10.0.0.0/8 to any port 16443
ufw allow from 10.0.0.0/8 to any port 19001
ufw allow from 10.0.0.0/8 to any port 25000
```

(the ports are secured )

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
