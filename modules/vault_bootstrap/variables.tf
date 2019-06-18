variable "backend" {
  description = "the backend used to build the code using terraform. Ex: gcs, aws, azure_rm"
}

variable "datatag" {}
variable "sdtag" {}
variable "project" {}

variable "vault_ips" {
  type = "list"
}

variable "consul_data_ips" {
  type = "list"
}

# variable "consul_data_ext_ips" {
#   type = "list"
# }
# variable "consul_sd_ext_ips" {
#   type = "list"
# }
# variable "depends_list" {
#   type = "list"
# }
variable "region" {
  description = "Region for the build environment. Ex: us-central1, us-east1, us-west1"
}

variable "env" {
  description = "environment of which the infrastructure is built for"
  default     = "dev"
}
variable "os_user" {}
# variable "ssh_public_key" {}
variable "ssh_private_key" {}

variable "tags" {
  type = "map"
}

# variable "serverinfo" {
#   type = "map"
# }
