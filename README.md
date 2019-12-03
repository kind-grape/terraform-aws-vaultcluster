# terraform-aws-vaultcluster

## Requirements
1. Access to the Hashi Binaries ()
2. AWS account, and environment variables set (AWS_SECRET_ACCESS_KEY, AWS_ACCESS_KEY_ID)
3. AWS Key Pair uploaded - Referenced in the code (see step 6 below)
4. Terraform 12
5. Certs to be created using the `cfssl-ca.sh` and `cfssl-cert.sh` and files stored in the `certs/` directory

## Pre-Setup
1. Build packer image
2. Generate new consul master key/token
2. Copy id_rsa and id_rsa.pub into varfiles directory
3. Create local copy of vars.tfvars based on vars.tfvars.example
4. Replace AMI value with new AMI
5. Replace SSH key key_name for the key stored in AWS that you wish to use to connect to servers with
6. Edit your MGMT Subnets (using cidr notation), including the IP you wish to access the environment.
7. Edit Tags accordingly
8. Set the count to 1 for consul and vault (depending if you want to use consul as a storage backend)
10. Set Desired, Max, Min capacity values for vault and consul
** run `0-setup` if the network and subnets are not already existing

## Certificates
1. ```consul tls ca create```
2. ```consul tls cert create -server -dc=${var.region}```
3. ```consul tls cert create -client -dc=${var.region}```

## Load Variables
1. ```export CONSUL_HTTP_ADDR=https://127.0.0.1:7501```
2. ```export CONSUL_HTTP_TOKEN=$(sudo cat /etc/consul.d/tokens/master)```

## Terraform Commands
1. ```terraform plan -var-file=../varfiles/setup.tfvars``` from 0-Setup
2. ```terraform plan -var-file=../varfiles/vars.tfvars``` from 1-env
** use ```terraform apply``` pointing to the correct variable file when complete
** If using Terraform Enterprise, put all the variables in the variables tab, and ignore having to point to variable files, or storing variable files with the root module. https://12factor.net/config

# Need to look at

https://github.com/hashicorp/IS-terraform-aws-vault-ansible/issues/3
