FROM debian:stable-slim
RUN apt update -qq \
&& apt install -yqq \
bash \
ca-certificates \
curl \
git-crypt \
gpg \
jq \
lsb-release \
unzip \
# doctl
&& export DOCTL_VERSION=$(curl https://api.github.com/repos/digitalocean/doctl/releases/latest | jq -r '.tag_name' | awk '{print substr($0,2)}') \
&& curl -sL https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz \
| tar xvz -C /usr/local/bin \
# kubeval
&& curl -sL https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz \
| tar xvz -C /usr/local/bin \
# kube-score
&& curl -sL https://github.com//zegl/kube-score/releases/download/v1.14.0/kube-score_1.14.0_linux_amd64.tar.gz \
| tar xvz -C /usr/local/bin \
# terraform
&& curl -sL https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
&& gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint \
&& echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
tee /etc/apt/sources.list.d/hashicorp.list \
# kubectl
&& curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" \
| tee /etc/apt/sources.list.d/kubernetes.list \
&& apt upgrade -yqq \
&& apt update -qq \
&& apt install -yqq kubectl terraform \
&& curl -sL https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash \
&& curl -sL https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash
