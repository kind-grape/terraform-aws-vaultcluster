variable "ssm_kms_deletion_days" {
  default = 7
}

variable "ssm_kms_key_rotate" {
  default = true
}

variable "https_enabled" {
  description = "Enable Vault certs"
  default     = false
}

variable "key_id" {
}

variable "create_cert" {
  type    = any
  default = null
}

variable "region" {
  description = "Region used to build all objects"
  default     = "ca-central-1"
}

variable "join_tag" {
  description = "tag used for auto join"
  default     = "AUTOJOIN"
}

variable "namespace" {
  description = "used to identify the client space, or client acronym"
  default     = "client001"
}

variable "vault_recovery_shares" {
  description = "Amount of recovery shards to create"
  default     = 5
}

# variable "module_depends_on" {
#   description = "Depends Variable used to cross polinate modules"
#   type        = any
#   default     = null
# }

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
