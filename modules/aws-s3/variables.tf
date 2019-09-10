variable "region" {
  description = "Region used to build all objects"
  default     = "us-west-2"
}

variable "bucket_name" {
  description = "Default bucket name"
  default     = "bucket_name"
}

variable "snapshot_name" {
  description = "Default bucket name"
  default     = "consul-snapshots"
}

variable "tags" {
  type = "map"
  description = "Default tags"
}
