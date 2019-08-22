variable "ssm_kms_deletion_days" {
  default = 7
}

variable "ssm_kms_key_rotate" {
  default = true
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