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
  default     = "dev"
}

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

variable "bootstrap" {
  type        = bool
  description = "Whether cluster should be deployed in bootstrap configuration"
  default     = true
}

variable "cloud_env" {
  description = "cloud environment - aws, gcp, azure"
  default     = "aws"
}

# variable "os_user" {
#   description = "Default OS User when VM is Created"
#   default     = "ec2-user"
# }

variable "address_space" {
  description = "Default Supernet that all networks reside within"
  type        = string
  default     = "172.21.0.0/16"
}

variable "key_name" {
  description = "Default Key Name for server access"
  type        = string
}

variable "subnet_id" {
  description = "Subnet where servers will reside"
}

variable "vpc_id" {
  description = "VPC where servers will reside"
  type        = string
  default     = "vpc-0000000000000000e"
}

variable "ami_owner_account" {
  description = "Account that owns the AMI used"
  type        = string
  default     = "123456789111"
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

variable "ingress_rules" {
  description = "List of ingress rules"
  type        = list(any)

  default = [
    "ssh-tcp",
  ]
}

variable "security_groups" {
  description = "Default Security Group IDs"
  type        = list(string)
  default     = ["sg-00000000000000000"]
}

variable "mgmt_subnets" {
  description = "List of subnets allowed to manage and connect to the services"
  type        = list(string)

  default = [
    "23.233.28.57/32",
    "174.114.254.19/32",
    "72.137.254.70/32"
  ]
}

variable "tags" {
  description = "Tags used across all resources that can be tagged"
  type        = map(string)
}

variable "customtags" {
  description = "Tags used across all resources that can be tagged"
  type        = map(string)

  default = {}
}

variable "snapshots" {
  description = "snapshot variables"
  type        = map(string)

  default = {}
}

variable "custom_snapshots" {
  description = "snapshot variables"
  type        = map(string)

  default = {
    bucket_name   = "consul-snapshots-bucket"
    snapshot_name = "consul-snapshot"
  }
}

variable "vault_extra_tags" {
  description = "Tags used across all resources that can be tagged"
  type        = map(string)
  default     = {}
}

variable "consul_storage_extra_tags" {
  description = "Tags used across all resources that can be tagged"
  type        = map(string)
  default     = {}
}

variable "consul_sd_extra_tags" {
  description = "Tags used across all resources that can be tagged"
  type        = map(string)
  default     = {}
}

variable "kms" {
  description = "Secrets Vault Values"
  type        = map(string)

  default = {
    iam_instance_profile_path = "/" # standard or premium
    key_deletion_window       = "30"
  }
}

# variable "vault_ports" {
#   description = "Ports required to run Consul Backend"
#   type        = map(string)
#
#   default = {}
# }
#
# variable "consul_ports" {
#   description = "Ports required to run Consul Backend"
#   type        = map(string)
#
#   default = {}
# }

# variable "custom_ports" {
#   description = "Ports required to run Consul Backend"
#   type        = map(string)
#
#   default = {
#     consul_server_rpc_port = "8300"
#     consul_serf_lan_port   = "8301"
#     consul_serf_wan_port   = "8302"
#     consul_http_port       = "8500"
#     consul_https_port      = "8501"
#     consul_dns_port        = "8600"
#     vault_api_port         = "8200"
#     vault_cluster_port     = "8201"
#   }
# }

variable "consul_storage" {
  description = "Default values for an instance"
  type        = map(string)

  default = {}
}

variable "custom_consul_storage" {
  description = "Default values for a storage instance"
  type        = map(string)

  default = {
    role          = "storage"
    datacenter    = "vault"
    ingress_rules = "consulbk-tcp,consulbk-cli-rpc-tcp,consulbk-webui-tcp,consulbk-webuis-tcp,consulbk-dns-tcp,consulbk-dns-udp,consulbk-serf-lan-tcp,consulbk-serf-lan-udp,consulbk-serf-wan-tcp,consulbk-serf-wan-udp"
    count         = 0
  }
}

variable "consul_snap" {
  description = "Default values for an instance"
  type        = map(string)

  default = {}
}

variable "custom_consul_snap" {
  description = "Default values for a snapshot instance"
  type        = map(string)

  default = {
    role          = "snapshot"
    datacenter    = "vault"
    ingress_rules = "consulbk-tcp,consulbk-cli-rpc-tcp,consulbk-webui-tcp,consulbk-webuis-tcp,consulbk-dns-tcp,consulbk-dns-udp,consulbk-serf-lan-tcp,consulbk-serf-lan-udp,consulbk-serf-wan-tcp,consulbk-serf-wan-udp"
    count         = 0
  }
}

variable "consul_sd" {
  description = "Default values for an instance"
  type        = map(string)

  default = {}
}

variable "custom_consul_sd" {
  description = "Default values for an instance"
  type        = map(string)

  default = {
    role          = "serviced"
    datacenter    = "consul"
    ingress_rules = "consul-tcp,consul-cli-rpc-tcp,consul-webui-tcp,consul-webuis-tcp,consul-dns-tcp,consul-dns-udp,consul-serf-lan-tcp,consul-serf-lan-udp,consul-serf-wan-tcp,consul-serf-wan-udp"
    count         = 0
  }
}

variable "vault" {
  description = "Default values for an instance"
  type        = map(string)

  default = {}
}

variable "custom_vault" {
  description = "Default values for an instance"
  type        = map(string)

  default = {
    role          = "vault"
    datacenter    = "vault"
    ingress_rules = "vault-tcp,vault-cluster-tcp"
    count         = 0
  }
}
