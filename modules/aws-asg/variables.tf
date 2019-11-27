variable "cluster_name" {
  description = "The name of the Consul cluster (e.g. Consul-stage). This variable is used to namespace all resources created by this module."
  type        = string
  default = "CHANGECLUSTERNAME"
}

variable "key_name" {
  description = "The AWS ssh key to use to build instances in the Consul cluster"
  type        = string
  default     = "default"
}

variable "subnet_id" {
  description = "Subnet where servers will reside"
  type = list(string)
  default     = ["subnet-0000000000000000e"]
}

variable "serverinfo" {
  description = "Default values for an instance"
  type        = map(string)

  default = {}
}

variable "custom_serverinfo" {
  description = "Default values for an instance"
  type        = map(string)

  default = {
    root_name         = "/"
    root_size         = "50"
    root_type         = "gp2"
    security_group    = ""
    ami               = "ami-0000000000000000a"
    size              = "t2.micro"
    health_check_type = "EC2"
    server            = false
    https             = false
    version           = "1.5.1"
    role              = "blahrole"
    datacenter        = "dcblah"
    datacenter_consul = "dcblahcsl"
    ports             = "80,443"
    ingress_rules     = "consul-tcp,consul-cli-rpc-tcp,consul-webui-tcp,consul-webuis-tcp,consul-dns-tcp,consul-dns-udp,consul-serf-lan-tcp,consul-serf-lan-udp,consul-serf-wan-tcp,consul-serf-wan-udp"
    listening_port    = "8500"
    masterkey         = "1111111111111111111111=="
    agentkey          = "2222222222222222222222=="
    unbound           = false
    dnsmasq           = true
    autojoin          = false
    tlslistener       = false
    enterprise        = false
    enablesyslog      = false
    ui                = false
    count             = 0
    desired_capacity  = 1
    max_size          = 1
    min_size          = 1
    startindex        = 0
  }
}

variable "tags" {
  description = "Tags used across all resources that can be tagged"
  type        = map(string)

  default = {}
}

variable "customtags" {
  description = "Tags used across all resources that can be tagged"
  type        = map(string)

  default = {
    client     = "TESTCLIENT"
    costcenter = "TESTCOMPANY"
    auto_join  = "AUTOJOIN"
  }
}

variable "iam_instance_profile" {
}

variable "user_data" {
  description = "Variable place holder for rendered User Data scripts"
  default     = "../scripts/user_data.sh"
}

variable "security_groups" {
  description = "Default Security Group IDs"
  type        = list(string)
  default     = ["sg-00000000000000000"]
}

variable "ami" {
  description = "Default AMI to use"
  default     = "ami-0000000000000000a"
}

# variable "additional_tags" {
#   description = "A list of maps to add tags to scaling group and instances"
#   type        = list(string)
#
#   default = []
# }

variable "health_check_grace_period" {
  description = "Time, in seconds, after instance comes into service before checking health."
  default     = 300
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  default     = "10m"
}

variable "enabled_metrics" {
  description = "List of autoscaling group metrics to enable."
  type        = list(string)
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default."
  type        = string
  default     = "Default"
}
