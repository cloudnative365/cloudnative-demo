#!/bin/bash -ex
#sudo curl -sSL https://get.docker.com/ | sh
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl docker.io

# cat <<EOF >>/etc/hosts
# 10.0.1.97 ip-10-0-1-97
# 10.0.1.18 ip-10-0-1-18
# 10.0.1.25 ip-10-0-1-25
# EOF


# kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.0.1.97
# kubeadm init phase addon all
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml
