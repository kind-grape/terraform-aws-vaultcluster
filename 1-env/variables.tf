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
  default     = "env"
}

variable "region" {
  description = "Region used to build all objects"
  default     = "ca-central-1"
}

variable "os_user" {
  description = "Default OS User when VM is Created"
  default     = "ec2-user"
}

# variable "ssh_public_key_location" {
#   description = "Public Key location from within Terraform"
#   type        = "string"
#   default     = "../varfiles/id_rsa.pub"
# }

variable "address_space" {
  description = "Default Supernet that all networks reside within"
  type        = "string"
  default     = "172.21.0.0/16"
}

variable "key_name" {
  description = "Default Key Name for server access"
  type        = "string"
  default     = "default"
}

variable "subnet_id" {
  description = "Subnet where servers will reside"
  type        = "string"
  default     = "subnet-0000000000000000e"
}

variable "vpc_id" {
  description = "VPC where servers will reside"
  type        = "string"
  default     = "vpc-0000000000000000e"
}

variable "subnets" {
  description = "public and private subnets"
  type        = "map"

  default = {
    public  = "172.21.1.0/24"
    private = "172.21.2.0/24"
  }
}

variable "dns_servers" {
  description = "Default DNS Servers that the servers will use to resolve"
  type        = "list"

  default = [
    "1.1.1.1",
    "1.0.0.1",
  ]
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type        = "list"

  default = [
    "ssh-tcp",
  ]
}

variable "security_groups" {
  description = "Default Security Group IDs"
  type        = "list"

  default = [
    "sg-00000000000000000",
  ]
}

variable "mgmt_subnets" {
  description = "List of subnets allowed to manage and connect to the services"
  type        = "list"

  default = [
    "172.21.1.0/24",
    "172.21.2.0/24",
  ]
}

variable depends_on {
  description = "Dependencies"
  default     = []
  type        = "list"
}

variable "tags" {
  description = "Tags used across all resources that can be tagged"
  type        = "map"

  default = {
    client     = "TESTCLIENT"
    costcenter = "TESTCOMPANY"
  }
}

variable "vault_extra_tags" {
  description = "Tags used across all resources that can be tagged"
  type        = "map"
  default = {}
}

variable "consul_bk_extra_tags" {
  description = "Tags used across all resources that can be tagged"
  type        = "map"
  default = {}
}

variable "kms" {
  description = "Secrets Vault Values"
  type        = "map"

  default = {
    iam_instance_profile_path = "/"  # standard or premium
    key_deletion_window       = "30"
  }
}

variable "consul_bk" {
  description = "Default values for an instance"

  default = {
    root_name         = "/"
    root_size         = "50"
    root_type         = "gp2"
    security_group    = ""
    ami               = "ami-0000000000000000a"
    size              = "t2.micro"
    health_check_type = "EC2"
    backup            = false
    role              = "cslbk"
    datacenter        = "vault"
    datacenter_consul = "csl"
    ports             = "8300,8301,8302,8500,8600,7300,7301,7302,7500,7600"
    ingress_rules     = "consulbk-tcp,consulbk-cli-rpc-tcp,consulbk-webui-tcp,consulbk-dns-tcp,consulbk-dns-udp,consulbk-serf-lan-tcp,consulbk-serf-lan-udp,consulbk-serf-wan-tcp,consulbk-serf-wan-udp"
    listening_port    = "7500"
    autojoin          = false
    tlslistener       = false
    enterprise        = false
    enablesyslog      = false
    ui                = true
    count             = 0
    max_size          = 3
    min_size          = 0
    startindex        = 0
  }
}

variable "consul_bk_ports" {
  description = "Ports required to run Consul Backend"
  type        = "map"

  default = {
    server_rpc_port  = "7300"
    serf_lan_port = "7301"
    serf_wan_port = "7302"
    http_port = "-1"
    https_port = "7501"
    dns_port = "7600"
  }
}

variable "consul_sd" {
  default = {
    root_name         = "/"
    root_size         = "50"
    root_type         = "gp2"
    security_group    = ""
    ami               = "ami-0000000000000000a"
    size              = "t2.micro"
    health_check_type = "EC2"
    backup            = false
    role              = "cslsd"
    datacenter        = "vault"
    datacenter_consul = "csl"
    ports             = "8300,8301,8302,8500,8600,7300,7301,7302,7500,7600"
    ingress_rules     = "consul-tcp,consul-cli-rpc-tcp,consul-webui-tcp,consul-dns-tcp,consul-dns-udp,consul-serf-lan-tcp,consul-serf-lan-udp,consul-serf-wan-tcp,consul-serf-wan-udp"
    listening_port    = "8500"
    autojoin          = false
    tlslistener       = false
    enterprise        = false
    enablesyslog      = false
    masterkey         = "1111111111111111111111=="
    agentkey          = "2222222222222222222222=="
    ui                = true
    count             = 0
    max_size          = 3
    min_size          = 0
    startindex        = 0
  }
}

variable "vault" {
  default = {
    root_name         = "/"
    root_size         = "50"
    root_type         = "gp2"
    security_group    = ""
    ami               = "ami-0000000000000000b"
    size              = "t2.micro"
    health_check_type = "EC2"
    backup            = false
    role              = "vault"
    datacenter        = "vault"
    datacenter_consul = "csl"
    ports             = "8200,8201"
    ingress_rules     = "vault-tcp,vault-cluster-tcp"
    listening_port    = "8200"
    autojoin          = false
    tlslistener       = false
    enterprise        = false
    enablesyslog      = false
    ui                = true
    count             = 0
    max_size          = 3
    min_size          = 0
    startindex        = 0
  }
}
