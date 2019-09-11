variable "region" {
  description = "Region used to build all objects"
  default     = "us-west-2"
}

variable "snapshots" {
  description = "snapshot variables"
  type = "map"
  default = {
    bucket_name       = "consul-snapshots-bucket"
    snapshot_name     = "consul-snapshots"
  }
}

variable "tags" {
  type = "map"
  description = "Default tags"
}

variable "serverinfo" {
  default = {}
}
