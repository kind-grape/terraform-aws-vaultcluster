variable "name_prefix" {
  description = "Name (or prefix) for the KMS resources created"
}

variable "tags" {
  description = "Map of tags for the KMS key"
  type        = "map"
  default     = {}
}

variable "kmsinfo" {
  description = "Map of tags for the KMS key"
  type        = "map"
  default     = {}
}

variable "snapshots" {
  description = "snapshot variables"
  type = "map"
  default = {
    bucket_name       = "consul-snapshots-bucket"
    snapshot_name     = "consul-snapshot"
  }
}
