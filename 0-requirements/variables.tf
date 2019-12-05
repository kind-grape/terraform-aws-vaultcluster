variable "region" {
  description = "Region used to build all objects"
  default     = "ca-central-1"
}

variable "domain" {
  description = "Client domain"
  default     = "example.com"
}

variable "certs" {
  description = "Certificate details"
  type        = map(string)
  default     = {}
}

variable "example_cert" {
  description = "Certificate details"
  type        = map(string)
  default = {
    DC       = "vault"
    COUNTRY  = "CA"
    STATE    = "Ontario"
    LOCATION = "Ottawa"
    ORG      = "ACME"
    OU       = "IT"
  }
}
