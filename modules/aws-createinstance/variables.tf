variable "os_user" {}
variable "user_data" {}
variable "key_name" {}
variable "hostname" {}
variable "security_groups" {}

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

variable "environment" {}
