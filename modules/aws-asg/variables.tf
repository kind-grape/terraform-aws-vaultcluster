variable "cluster_name" {
  description = "The name of the Consul cluster (e.g. Consul-stage). This variable is used to namespace all resources created by this module."
  type        = "string"
}

variable "key_name" {
  description = "The AWS ssh key to use to build instances in the Consul cluster"
  type        = "string"
}

variable "subnet_id" {
  description = "A list private subnet IDs the Consul cluster will be deployed into"
  type        = "list"
}

variable "serverinfo" {
  default = {}
}

variable "iam_instance_profile" {}
variable "user_data" {}

variable "security_groups" {
  description = "A list of security groups to attach to instances in the Consul cluster beyond the standard Consul ones"
  type        = "list"
  default     = []
}

variable "tags" {
  default = {}
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
