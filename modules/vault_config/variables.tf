variable "backend" {
  description = "the backend used to build the code using terraform. Ex: gcs, aws, azure_rm"
}

variable "project" {
  description = "The project to deploy to, if not set the default provider project is used."
  default     = ""
}

variable "chef_project" {
  description = "Chef Project repository with vanilla templates to get an environment up and running"
  default = "vaultcluster"
}

variable "playfile" {
  description = ""
  default = "boostrap.yml"
}

variable "sdenckey" {}
variable "dataenckey" {}
variable "sdsrvnodes" {}
variable "datasrvnodes" {}
variable "datatag" {}
variable "sdtag" {}
variable "key_ring" {}
variable "crypto_key" {}
variable "seal" {}

variable "region" {
  description = "Region for the build environment. Ex: us-central1, us-east1, us-west1"
}

variable "env" {
  description = "environment of which the infrastructure is built for"
  default     = "dev"
}

variable "chef_envfile" {
  description = "Chef Environment file used to render values required to build your environment"
  default = "env.json"
}

variable "os_user" {}

variable "ssh_private_key" {}

variable "tags" {
  type = "map"
}

variable "serverinfo" {
  type = "map"
}

variable "depends_list" {
  type = "list"
}

variable "vault_ips" {
  type = "list"
}
