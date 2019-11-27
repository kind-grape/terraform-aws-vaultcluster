variable "name_prefix" {
  description = "Name (or prefix) for the KMS resources created"
}

variable "tags" {
  description = "Map of tags for the KMS key"
  type        = map(string)
  default     = {}
}

variable "custom_tags" {
  description = "Map of tags for the KMS key"
  type        = map(string)
  default     = {
    client                  = "CLIENT"
    costcenter              = "CLIENTAWS"
  }
}

variable "kmsinfo" {
  description = "Map of tags for the KMS key"
  type        = map(string)
  default = {}
}

variable "custom_kmsinfo" {
  description = "Map of tags for the KMS key"
  type        = map(string)
  default = {
    iam_instance_profile_path = "/" # standard or premium
    key_deletion_window       = "30"
  }
}

variable "snapshots" {
  description = "snapshot variables"
  type        = map(string)
  default = {
    bucket_name   = "consul-snapshots-bucket"
    snapshot_name = "consul-snapshot"
  }
}
