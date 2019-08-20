variable "user_data" {}
variable "kms_key_id" {}

variable "ports" {
  default = {}
}

variable "region" {}

variable "tags" {
  default = {}
}

variable "serverinfo" {
  default = {}
}

variable "server_cert" {
  default = "../certs/ca-central-1-server-consul-0.pem"
}
variable "server_key" {
  default = "../certs/ca-central-1-server-consul-0-key.pem"
}
variable "client_cert" {
  default = "../certs/ca-central-1-client-consul-0.pem"
}
variable "client_key" {
  default = "../certs/ca-central-1-client-consul-0-key.pem"
}
variable "root_cert" {
  default = "../certs/consul-agent-ca.pem"
}
