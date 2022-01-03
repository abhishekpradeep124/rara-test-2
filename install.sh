#! /usr/bin/env bash

set -e

sudo apt install awscli -y


HELM_S3_PLUGIN_VERSION="0.10.0"
AWS_DEFAULT_REGION="ap-southeast-1"
# install kubectl
curl -L "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl
kubectl version --client

sudo cp ./kubectl /usr/local/bin/kubectl 
kubectl version --short --client
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# install Helm
# https://helm.sh/docs/intro/install/#from-script
wget -O helm.tar.gz https://get.helm.sh/helm-v3.5.4-linux-amd64.tar.gz
tar -zxvf helm.tar.gz
mv linux-amd64/helm /usr/local/bin/helm

# install S3 plugin for Helm
helm plugin install https://github.com/hypnoglow/helm-s3.git --version $HELM_S3_PLUGIN_VERSION

# cleanup
rm /var/cache/apk/*
rm -rf /tmp/*


