# Packer and Vault Enterprise AMI Builders

Create AMIs for Consul and Vault Enterprise using Packer and Ansible. Uses Amazon Linux 2 as the source AMI.

## Steps

To create an AMI with Consul Enterprise:

* Fetch enterprise binary for Consul Enterprise (current version 1.5.1)
* In the Packer folder, copy amzn2-app-ent-1.5.1.json.example to amzn2-consul-ent.json
* Update variables amzn2-consul-ent.json:
	* Set app_name to consul
	* Set version to 1.5.1 (or version downloaded)
	* Set region to desired region
	* Set vpc_id
	* Set subnet_id (must be reachable by packer, public subnets easiest)
* Copy zip archive to hashi-install Ansible role
	* cp consul*-enterprise_*.zip roles/hashi-install/files/
* Validate packer manifest
	* packer validate packer build amzn2-consul-ent.json
* Build AMI
	* packer build amzn2-consul-ent.json

Follow the same instructions above to create an AMI for Vault Enterprise. Use `vault` as the app name in the Packer manifest and copy vault*-enterprise_*.zip to roles/hashi-install/files/.