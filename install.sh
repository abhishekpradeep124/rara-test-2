#! /usr/bin/env bash

export HELM_S3_PLUGIN_VERSION="0.10.0"

sudo apt install awscli -y

curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
curl -o kubectl.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl.sha256
openssl sha1 -sha256 kubectl
chmod +x ./kubectl
sudo cp ./kubectl /usr/local/bin/kubectl 

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin


# install Helm
# https://helm.sh/docs/intro/install/#from-script
wget -O helm.tar.gz https://get.helm.sh/helm-v3.5.4-linux-amd64.tar.gz
tar -zxvf helm.tar.gz
mv linux-amd64/helm /usr/local/bin/helm

# install S3 plugin for Helm
helm plugin install https://github.com/hypnoglow/helm-s3.git --version $HELM_S3_PLUGIN_VERSION

aws --version
kubectl version --short --client
eksctl version
helm version

