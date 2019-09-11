variable "user_data" {
  description = "Variable place holder for rendered User Data scripts"
  default     = "../scripts/user_data.sh"
}

variable "kms_key_id" {
  description = "ID of the KMS Key store"
}

variable "ports" {
  description = "Ports required to run Consul Backend"
  type        = "map"

  default = {
    consulbk_server_rpc_port = "7300"
    consulbk_serf_lan_port   = "7301"
    consulbk_serf_wan_port   = "7302"
    consulbk_http_port       = "-1"
    consulbk_https_port      = "7501"
    consulbk_dns_port        = "7600"
    consulsd_server_rpc_port = "8300"
    consulsd_serf_lan_port   = "8301"
    consulsd_serf_wan_port   = "8302"
    consulsd_http_port       = "-1"
    consulsd_https_port      = "8501"
    consulsd_dns_port        = "8600"
    vault_api_port           = "8200"
    vault_cluster_port       = "8201"
  }
}

variable "snapshots" {
  default = {
    bucket_name       = "consul-snapshots-bucket"
    snapshot_name     = "consul-snapshots"
  }
}

variable "region" {
  description = "Region used to build all objects"
  default     = "ca-central-1"
}

variable "tags" {
  description = "Tags used across all resources that can be tagged"
  type        = "map"
}

variable "serverinfo" {
  default = {}
}

variable "unseal_cloud" {
  description = "Cloud acronym used for vault config to enable auto-unseal"
  default     = "awskms"
}

variable "vault_telemetry" {
  description = "enable/disable vault telemetry"
  default     = false
}
