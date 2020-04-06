# terraform-aws-vaultcluster

## Requirements
1. Access to the Hashi Binaries ()
1. AWS account, and environment variables set (AWS_SECRET_ACCESS_KEY, AWS_ACCESS_KEY_ID) - Requires iam:CreatePolicy permissions in AWS
1. AWS Key Pair uploaded - Referenced in the code (see step 6 below)
1. Terraform 12
1. run 0-setup to create required network (if not already provided)
1. run 0-requirements to create necessary Certificates (Mac Users need to run ```brew install cfssl```)

## Pre-Setup
1. Build packer image
1. Copy id_rsa and id_rsa.pub into varfiles directory
1. Create local copy of `vars.tfvars` based on `varfiles/vars.tfvars.example`
1. Create local copy of `user_data.sh` based on `scrips/user_data.sh.example`
1. Update Vault/Consul version in your vars.tfvars, so the data.tf may search for your AMIs
1. Replace SSH key key_name for the key stored in AWS that you wish to use to connect to servers with
1. Edit your MGMT Subnets (using cidr notation), including the IP you wish to access the environment.
1. Edit Tags accordingly
1. Set the count to 1 for consul and vault (depending if you want to use consul as a storage backend)
1. Set Desired, Max, Min capacity values for vault and consul
** run `0-setup` if the network and subnets are not already existing

## Load Variables
1. ```export CONSUL_HTTP_ADDR=https://127.0.0.1:{PORT OF CHOICE}```
2. ```export CONSUL_HTTP_TOKEN=$(sudo cat /etc/consul.d/tokens/master)```

## Terraform Commands
1. ```terraform plan -var-file=../varfiles/setup.tfvars``` from 0-Setup
1. ```terraform plan -var-file=../varfiles/vars.tfvars``` from 1-env
** use ```terraform apply``` pointing to the correct variable file when complete
** If using Terraform Enterprise, put all the variables in the variables tab, and ignore having to point to variable files, or storing variable files with the root module. https://12factor.net/config

# Need to look at

https://github.com/hashicorp/IS-terraform-aws-vault-ansible/issues/3
