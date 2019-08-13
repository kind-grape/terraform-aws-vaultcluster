# This file was generated from values defined in rules.tf using update_groups.sh.
###################################
# DO NOT CHANGE THIS FILE MANUALLY
###################################

variable "auto_ingress_rules" {
  description = "List of ingress rules to add automatically"
  type        = "list"
  default     = ["https-8443-tcp"]
}

variable "auto_ingress_with_self" {
  description = "List of maps defining ingress rules with self to add automatically"
  type        = "list"
  default     = [{ "rule" = "all-all" }]
}

variable "auto_egress_rules" {
  description = "List of egress rules to add automatically"
  type        = "list"
  default     = ["all-all"]
}

variable "auto_egress_with_self" {
  description = "List of maps defining egress rules with self to add automatically"
  type        = "list"
  default     = []
}

# Computed
variable "auto_computed_ingress_rules" {
  description = "List of ingress rules to add automatically"
  type        = "list"
  default     = []
}

variable "auto_computed_ingress_with_self" {
  description = "List of maps defining computed ingress rules with self to add automatically"
  type        = "list"
  default     = []
}

variable "auto_computed_egress_rules" {
  description = "List of computed egress rules to add automatically"
  type        = "list"
  default     = []
}

variable "auto_computed_egress_with_self" {
  description = "List of maps defining computed egress rules with self to add automatically"
  type        = "list"
  default     = []
}

# Number of computed rules
variable "auto_number_of_computed_ingress_rules" {
  description = "Number of computed ingress rules to create by name"
  default     = 0
}

variable "auto_number_of_computed_ingress_with_self" {
  description = "Number of computed ingress rules to create where 'self' is defined"
  default     = 0
}

variable "auto_number_of_computed_egress_rules" {
  description = "Number of computed egress rules to create by name"
  default     = 0
}

variable "auto_number_of_computed_egress_with_self" {
  description = "Number of computed egress rules to create where 'self' is defined"
  default     = 0
}

