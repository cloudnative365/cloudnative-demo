#!/bin/bash -ex

##########################
# Pre-configuration for OS
##########################
# cat <<EOF >>/etc/hosts
# 10.0.1.97 ip-10-0-1-97
# 10.0.1.18 ip-10-0-1-18
# 10.0.1.25 ip-10-0-1-25
# EOF

##########################
# Install Runtime
##########################

# Install Docker CE
## Set up the repository:
### Install packages to allow apt to use a repository over HTTPS
apt-get update && apt-get install \
  apt-transport-https ca-certificates curl software-properties-common

### Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

### Add Docker apt repository.
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

## Install Docker CE.
apt-get update && apt-get install -y \
  containerd.io=1.2.10-3 \
  docker-ce=5:19.03.4~3-0~ubuntu-$(lsb_release -cs) \
  docker-ce-cli=5:19.03.4~3-0~ubuntu-$(lsb_release -cs)

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "registry-mirrors": ["https://gvfjy25r.mirror.aliyuncs.com"]
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.
systemctl daemon-reload
systemctl restart docker

#####################
# Install Kubernetes
#####################
# Install Kubernetes with kubadm
## Set up the repository:
### Install packages to allow apt to use a repository over HTTPS
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

### Add Kubernetes’s official GPG key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

## Install Docker CE.
apt-get update && apt-get install -y \
  kubectl kubelet kubeadm


#####################
# Install addons
#####################

# kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.0.1.97
# kubeadm init phase addon all
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml
# git clone https://github.com/kubernetes-sigs/metrics-server.git
# kubectl create -f metrics-server/deploy/1.8+/
# --kubelet-insecure-tls
