#!/bin/sh
curl -O https://releases.hashicorp.com/terraform/0.6.7/terraform_0.6.7_linux_amd64.zip
sudo unzip terraform_0.6.7_linux_amd64.zip -d /opt
rm -r terraform_0.6.7_linux_amd64.zip
