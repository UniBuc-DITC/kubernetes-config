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
