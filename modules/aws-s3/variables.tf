variable "region" {
  description = "Region used to build all objects"
  default     = "us-west-2"
}

variable "snapshots" {
  description = "snapshot variables"
  type        = map(string)
  default = {
    bucket_name   = "consul-snapshots-bucket"
    snapshot_name = "consul-snapshot"
  }
}

variable "tags" {
  type        = map(string)
  description = "Default tags"
}

variable "serverinfo" {
  default = {}
}

