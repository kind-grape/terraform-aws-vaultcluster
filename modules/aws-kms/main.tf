data "aws_iam_policy_document" "instance_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeInstances", "ssm:DescribeParameters", "ssm:GetParameter", "ssm:PutParameter", "ssm:UpdateInstanceInformation", "ssm:ListAssociations", "ec2messages:GetMessages", "ssm:ListInstanceAssociations"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "instance_role" {
  name               = "${var.name_prefix}-kms-role"
  tags               = "${var.tags}"
  assume_role_policy = "${data.aws_iam_policy_document.instance_role.json}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy" "instance_role" {
  name   = "consul-server-${var.name_prefix}"
  role   = "${aws_iam_role.instance_role.id}"
  policy = "${data.aws_iam_policy_document.policy.json}"
}

resource "aws_kms_key" "key" {
  description             = "Vault auto unseal key for ${var.name_prefix}"
  deletion_window_in_days = "${var.kmsinfo["key_deletion_window"]}"
  tags                    = "${var.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_kms_alias" "secretagent_alias" {
  name          = "alias/${var.name_prefix}"
  target_key_id = "${aws_kms_key.key.key_id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_kms_grant" "grant" {
  name              = "${var.name_prefix}-kms-grant"
  key_id            = "${aws_kms_key.key.key_id}"
  grantee_principal = "${aws_iam_role.instance_role.arn}"
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.name_prefix}-iam"
  path = "${var.kmsinfo["iam_instance_profile_path"]}"
  role = "${aws_iam_role.instance_role.name}"

  lifecycle {
    create_before_destroy = true
  }
}
