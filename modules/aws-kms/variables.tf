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
