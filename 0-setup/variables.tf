variable "backend" {
  description = "Default Backend for the module to leverage"
  default     = "s3"
}

variable "bucket" {
  description = "Storage account container where all terraform state files are to be stored"
  default     = "TEST"
}

variable "environment" {
  description = "Environment name used to distinguish unique variables and remote state seggregation"
  default     = "setup"
}

variable "region" {
  description = "Region used to build all objects"
  default     = "ca-central-1"
}

variable "os_user" {
  description = "Default OS User when VM is Created"
  default     = "ec2-user"
}

variable "address_space" {
  description = "Default Supernet that all networks reside within"
  type        = string
  default     = "172.21.0.0/16"
}

variable "subnets" {
  description = "public and private subnets"
  type        = map(string)

  default = {
    public  = "172.21.11.0/24,172.21.12.0/24,172.21.13.0/24"
    private = "172.21.21.0/24,172.21.22.0/24,172.21.23.0/24"
  }
}

variable "dns_servers" {
  description = "Default DNS Servers that the servers will use to resolve"
  type        = list(string)

  default = [
    "1.1.1.1",
    "1.0.0.1",
  ]
}

variable "tags" {
  description = "Tags used across all resources that can be tagged"
  type        = map(string)

  default = {
    client     = "TESTCLIENT"
    costcenter = "TESTCOMPANY"
  }
}
