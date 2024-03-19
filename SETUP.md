# Kubernetes node setup

This document describes the steps which have to be taken when preparing a new node to be added to the Kubernetes cluster.

For simplicity and consistency, all of our Kubernetes machines should run the latest LTS version of [Ubuntu Server](https://ubuntu.com/), with all updates installed.

## Swap space configuration

As [recommended by Kubernetes best practices](https://serverfault.com/a/881518/957097), we [disable swap](https://askubuntu.com/questions/214805/how-do-i-disable-swap) and remove the swap file on all machines which also run pods, to ensure consistent performance.

## Installing RKE2

We will install Rancher's [RKE2](https://docs.rke2.io/) Kubernetes distribution. We prefer always using the _latest_ version of Kubernetes, which can be installed on a Linux machine by running:

```bash
curl -sfL https://get.rke2.io | INSTALL_RKE2_CHANNEL=latest sh -
```

## Upgrading RKE2

First, follow [the steps in the official documentation](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/) to safely drain a node and mark it as unschedulable:

```bash
kubectl drain --ignore-daemonsets <node name>
```

After waiting to ensure all services get moved off the node, you can stop RKE2 and all of its associated services by running:

```bash
rke2-killall.sh
```

Upgrade all system packages, cleanup old files and then upgrade the installed RKE2 version by running

```bash
curl -sfL https://get.rke2.io | INSTALL_RKE2_CHANNEL=latest sh -
```

(same command as when installing it the first time)

Reboot and wait for the node to start up and rejoin the cluster.

Finally, uncordon it and allow workloads to be scheduled on it again by using:

```bash
kubectl uncordon <node name>
```

## Freeing up disk space

To remove unused images from the `containerd` cache, use the command:

```bash
crictl rmi --prune
```

<!-- TODO: need to double-check this. How does NAT affect these rules?
## Firewall configuration

We will use the [Uncomplicated Firewall (UFW)](https://wiki.ubuntu.com/UncomplicatedFirewall) for network protection. It has to be [configured](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu) to allow communication between the node's control planes.

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
