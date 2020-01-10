data "aws_availability_zones" "available" {}

resource "aws_placement_group" "consul_asg" {
  count    = local.serverinfo["count"] >= 1 ? 1 : 0
  name     = var.cluster_name
  strategy = "spread"
}

resource "aws_launch_configuration" "consul_instance_asg" {
  count                = local.serverinfo["count"] >= 1 ? 1 : 0
  name                 = "${var.cluster_name}-asg-cfg"
  image_id             = var.ami
  instance_type        = local.serverinfo["size"]
  iam_instance_profile = var.iam_instance_profile
  security_groups      = var.security_groups
  key_name             = var.key_name
  user_data            = var.user_data

  ## In place to allow auto scale group to not destroy when incrementing the desired capacity
  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "aws_autoscaling_group" "consul_asg" {
  count                = local.serverinfo["count"] >= 1 ? 1 : 0
  name                 = "${var.cluster_name}-asg"
  launch_configuration = aws_launch_configuration.consul_instance_asg[0].name
  availability_zones   = [data.aws_availability_zones.available.id]
  vpc_zone_identifier  = var.subnet_id
  placement_group      = aws_placement_group.consul_asg[0].id

  min_size             = local.serverinfo["min_size"]
  max_size             = local.serverinfo["max_size"]
  desired_capacity     = local.serverinfo["desired_capacity"]
  termination_policies = [var.termination_policies]

  health_check_type         = "EC2"
  health_check_grace_period = var.health_check_grace_period
  wait_for_capacity_timeout = var.wait_for_capacity_timeout

  enabled_metrics = var.enabled_metrics

  lifecycle {
    create_before_destroy = true
  }

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.

  dynamic "tag" {
    for_each = local.tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  tag {
    key                 = "Name"
    value               = var.cluster_name
    propagate_at_launch = true
  }

  tag {
    key = "auto_join"
    value = replace(local.tags["auto_join"], "AUTOJOIN", local.serverinfo["datacenter"],)
    propagate_at_launch = true
  }

  # tags = [
  #   {
  #     "key"                 = "Name"
  #     "value"               = var.cluster_name
  #     "propagate_at_launch" = true
  #   },
  #   {
  #     "key" = "auto_join"
  #     "value" = replace(local.tags["auto_join"], "AUTOJOIN", local.serverinfo["datacenter"],)
  #     "propagate_at_launch" = true
  #   },
  # ]

  # tags = [
  #   list(
  #     map("key", "Name", "value", var.cluster_name, "propagate_at_launch", true),
  #     map("key", "auto_join", "value", replace(local.tags["auto_join"], "AUTOJOIN", local.serverinfo["datacenter"],), "propagate_at_launch", true)
  #   )
  # ]

  # tags = ["${concat(
  #   list(
  #     map("key", "auto_join", "value", replace(local.tags["auto_join"], "AUTOJOIN",local.serverinfo["datacenter"]), "propagate_at_launch", true),
  #     map("key", "Name", "value", var.cluster_name, "propagate_at_launch", true)
  #   ),
  #   var.additional_tags)
  # }"]
  #   concat(
  #     [
  #       {
  #         "key"                 = "Name"
  #         "value"               = var.cluster_name
  #         "propagate_at_launch" = true
  #       },
  #       {
  #         "key" = "auto_join"
  #         "value" = replace(
  #           local.tags["auto_join"],
  #           "AUTOJOIN",
  #           local.serverinfo["datacenter"],
  #         )
  #         "propagate_at_launch" = true
  #       },
  #     ],
  #     var.additional_tags,
  #   ),
  # ]
}
