locals {
  kmsinfo = merge(var.custom_kmsinfo, var.kmsinfo)
  tags = merge(var.custom_tags, var.tags)
}

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
    actions   = ["ec2:DescribeInstances", "ssm:DescribeParameters", "ssm:GetParameter", "ssm:PutParameter", "ssm:UpdateInstanceInformation", "ssm:ListAssociations", "ec2messages:GetMessages", "ssm:ListInstanceAssociations", "kms:DescribeKey"]
    resources = ["*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject", "s3:DeleteObject"]
    resources = ["arn:aws:s3:::${var.snapshots["bucket_name"]}/*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucketVersions", "s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.snapshots["bucket_name"]}"]
  }
}

resource "aws_iam_role" "instance_role" {
  name               = "${var.name_prefix}-kms-role"
  tags               = local.tags
  assume_role_policy = data.aws_iam_policy_document.instance_role.json

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy" "instance_role" {
  name   = "consul-server-${var.name_prefix}"
  role   = aws_iam_role.instance_role.id
  policy = data.aws_iam_policy_document.policy.json
}

resource "aws_kms_key" "key" {
  description             = "Vault auto unseal key for ${var.name_prefix}"
  deletion_window_in_days = local.kmsinfo["key_deletion_window"]
  tags                    = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_kms_alias" "secretagent_alias" {
  name          = "alias/${var.name_prefix}"
  target_key_id = aws_kms_key.key.key_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_kms_grant" "grant" {
  name              = "${var.name_prefix}-kms-grant"
  key_id            = aws_kms_key.key.key_id
  grantee_principal = aws_iam_role.instance_role.arn
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey", "DescribeKey"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.name_prefix}-iam"
  path = local.kmsinfo["iam_instance_profile_path"]
  role = aws_iam_role.instance_role.name

  lifecycle {
    create_before_destroy = true
  }
}
