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
