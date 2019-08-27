variable "cluster_name" {
  description = "The name of the Consul cluster (e.g. Consul-stage). This variable is used to namespace all resources created by this module."
  type        = "string"
}

variable "key_name" {
  description = "The AWS ssh key to use to build instances in the Consul cluster"
  type        = "string"
  default     = "default"
}

variable "subnet_id" {
  description = "Subnet where servers will reside"
  default     = ["subnet-0000000000000000e"]
}

variable "serverinfo" {
  default = {}
}

variable "iam_instance_profile" {}

variable "user_data" {
  description = "Variable place holder for rendered User Data scripts"
  default     = "../scripts/user_data.sh"
}

variable "security_groups" {
  description = "Default Security Group IDs"
  type        = "list"
  default = ["sg-00000000000000000"]
}

variable "tags" {
  description = "Tags used across all resources that can be tagged"
  type        = "map"

  default = {
    client     = "TESTCLIENT"
    costcenter = "TESTCOMPANY"
    auto_join  = "AUTOJOIN"
  }
}

variable "ami" {
  description = "Default AMI to use"
  default     = "ami-0000000000000000a"
}

variable "additional_tags" {
  description = "A list of maps to add tags to scaling group and instances"
  type        = "list"

  # list(
  #   map("key", "TAG_NAME", "value", "TAG_VALUE", "propagate_at_launch", true)
  # )
  default = []
}

variable "health_check_grace_period" {
  description = "Time, in seconds, after instance comes into service before checking health."
  default     = 300
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = "string"
  default     = "10m"
}

variable "enabled_metrics" {
  description = "List of autoscaling group metrics to enable."
  type        = "list"
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default."
  type        = "string"
  default     = "Default"
}
