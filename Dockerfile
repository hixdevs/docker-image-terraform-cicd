FROM debian:stable-slim
RUN apt update -qq \
&& apt install -yqq \
bash \
curl \
git-crypt \
gpg \
lsb-release \
unzip \
&& curl -sL https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
&& gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint \
&& echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
tee /etc/apt/sources.list.d/hashicorp.list \
&& apt upgrade -yqq \
&& apt update -qq \
&& apt install -yqq terraform \
&& curl -sL https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash \
&& curl -sL https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash
