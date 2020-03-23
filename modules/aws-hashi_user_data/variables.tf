variable "user_data" {
  description = "Variable place holder for rendered User Data scripts"
  default     = "../scripts/user_data.sh"
}

variable "kms_key_id" {
  description = "ID of the KMS Key store"
}

# variable "ports" {
#   description = "Ports required to run Consul Backend"
#   type        = map(string)
#
#   default = {}
# }
#
# variable "custom_ports" {
#   description = "Ports required to run Consul Backend"
#   type        = map(string)
#
#   default = {
#     consulbk_server_rpc_port = "7300"
#     consulbk_serf_lan_port   = "7301"
#     consulbk_serf_wan_port   = "7302"
#     consulbk_http_port       = "-1"
#     consulbk_https_port      = "7501"
#     consulbk_dns_port        = "7600"
#     consulsd_server_rpc_port = "8300"
#     consulsd_serf_lan_port   = "8301"
#     consulsd_serf_wan_port   = "8302"
#     consulsd_http_port       = "-1"
#     consulsd_https_port      = "8501"
#     consulsd_dns_port        = "8600"
#     vault_api_port           = "8200"
#     vault_cluster_port       = "8201"
#   }
# }

variable "consul_ports" {
  description = "Ports required to run Consul Backend"
  type        = map

  default = {}
}

variable "vault_ports" {
  description = "Ports required to run Consul Backend"
  type        = map

  default = {}
}

variable "custom_ports" {
  description = "Ports for vault cluster, or consul"
  type        = map

  default = {
    consul_server_rpc_port = "8300"
    consul_serf_lan_port   = "8301"
    consul_serf_wan_port   = "8302"
    consul_http_port       = "8500"
    consul_https_port      = "8501"
    consul_dns_port        = "8600"
    vault_api_port           = "8200"
    vault_cluster_port       = "8201"
  }
}

variable "snapshots" {
  description = "snapshot variables"
  type        = map(string)
  default     = {}
}

variable "custom_snapshots" {
  description = "snapshot variables"
  type        = map(string)
  default = {
    bucket_name   = "consul-snapshots-bucket"
    snapshot_name = "consul-snapshot"
  }
}

variable "region" {
  description = "Region used to build all objects"
  default     = "ca-central-1"
}

variable "tags" {
  description = "Tags used across all resources that can be tagged"
  type        = map(string)

  default = {}
}

variable "customtags" {
  description = "Tags used across all resources that can be tagged"
  type        = map(string)

  default = {
    client     = "TESTCLIENT"
    costcenter = "TESTCOMPANY"
    auto_join  = "AUTOJOIN"
  }
}

variable "serverinfo" {
  default = {}
}
variable "custom_serverinfo" {
  default = {
    role             = "vault"
    desired_capacity = 1
    datacenter       = "vault"
    server           = false
    unbound          = false
    dnsmasq          = true
    https            = false
    tlslistener      = false
  }
}

variable "cloud_env" {
  description = "cloud environment - aws, gcp, azure"
  default     = "aws"
}

variable "bootstrap" {
  type        = bool
  description = "Whether cluster should be deployed in bootstrap configuration"
  default     = true
}

variable "unseal_cloud" {
  description = "Cloud acronym used for vault config to enable auto-unseal"
  default     = "awskms"
}

variable "vault_unseal" {
  description = "initialize = true, default = false"
  default     = false
}

variable "vault_telemetry" {
  description = "enable/disable vault telemetry"
  default     = false
}

variable "vault_recovery_shares" {
  description = "Amount of recovery shards to create"
  default     = 5
}

variable "vault_recovery_threshold" {
  description = "Amount of recovery shards required to recover"
  default     = 3
}
