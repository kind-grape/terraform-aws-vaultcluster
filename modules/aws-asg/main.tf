data "aws_availability_zones" "available" {}

resource "aws_placement_group" "consul_asg" {
  name     = "${var.cluster_name}"
  strategy = "spread"
}

resource "aws_launch_configuration" "consul_instance_asg" {
  count                = "${var.serverinfo["count"] >= 1 ? var.serverinfo["count"] : 0}"
  name_prefix          = "${var.cluster_name}"
  image_id             = "${var.serverinfo["ami"]}"
  instance_type        = "${var.serverinfo["size"]}"
  iam_instance_profile = "${var.iam_instance_profile}"
  security_groups      = ["${var.security_groups}"]
  key_name             = "${var.key_name}"
  user_data            = "${var.user_data}"
}

resource "aws_autoscaling_group" "consul_asg" {
  count                = "${var.serverinfo["count"] >= 1 ? var.serverinfo["count"] : 0}"
  name_prefix          = "${var.cluster_name}"
  launch_configuration = "${aws_launch_configuration.consul_instance_asg.name}"
  availability_zones   = ["${data.aws_availability_zones.available.id}"]
  vpc_zone_identifier  = "${var.subnet_id}"
  placement_group      = "${aws_placement_group.consul_asg.id}"

  min_size             = "${var.serverinfo["min_size"]}"
  max_size             = "${var.serverinfo["max_size"]}"
  desired_capacity     = "${var.serverinfo["desired_capacity"]}"
  termination_policies = ["${var.termination_policies}"]

  health_check_type         = "EC2"
  health_check_grace_period = "${var.health_check_grace_period}"
  wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"

  enabled_metrics = ["${var.enabled_metrics}"]

  lifecycle {
    create_before_destroy = true
  }

  tags = [
    "${concat(
      list(
        map(
          "key", "Name",
          "value", "${var.cluster_name}",
          "propagate_at_launch", true
        ),
        map(
          "key", "auto_join",
          "value", "${replace(var.tags["auto_join"], "AUTOJOIN", var.serverinfo["datacenter"])}",
          "propagate_at_launch", true
        )
      ),
      var.additional_tags)
    }",
  ]
}