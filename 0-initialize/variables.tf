variable "region" {
  description = "Region used to build all objects"
  default     = "ca-central-1"
}

variable "environment" {
  description = "Environment name used to distinguish unique variables and remote state seggregation"
  default     = "dev"
}

variable "terraform_bucket_name" {
  description = "The name of the s3 bucket where terraform.tfstate will be stored"
  default     = "gonecrazy-test-terraform-remote-state-storage-s3"
}

variable "tags" {
  default = {
    client     = "ExampleClient"
    costcenter = "ExampleClient"
  }
}
