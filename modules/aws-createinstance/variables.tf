variable "os_user" {}
variable "user_data" {
  default = "user_data.sh"
}
variable "key_name" {}
variable "hostname" {}
variable "security_groups" {}

# variable "azurename_prefix" {}
variable "subnet_id" {}

variable "consul_bk_ports" {
  default = {}
}
variable "region" {}

variable "tags" {
  default = {}
}

variable "serverinfo" {
  default = {}
}

# variable "serverscount" {}
variable "environment" {}

# variable "resource_group_name" {}
# variable "network_resource_group_name" {}
# variable "network_security_group_name" {}
# variable "network_security_group_id" {}
