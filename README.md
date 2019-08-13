# terraform-aws-vaultcluster

1. Build packer image
2. Generate new consul master key/token
2. Copy id_rsa and id_rsa.pub into varfiles directory
3. Create local copy of vars.tfvars based on vars.tfvars.example
4. Replace AMI value with new AMI
5. Replace SSH key key_name for the key stored in AWS that you wish to use to connect to servers with
6. Edit your MGMT Subnets (using cidr notation)
7. Edit Tags accordingly
8. Set the count to 1 for consul and vault (depending if you want to use consul as a storage backend)
9. Edit MasterKey for the generated token in step 2
10. Set Desired, Max, Min capacity values for vault and consul
