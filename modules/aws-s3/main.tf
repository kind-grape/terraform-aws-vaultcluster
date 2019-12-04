# data "aws_iam_policy_document" "s3policy" {
#   statement {
#     effect    = "Allow"
#     actions   = ["s3:PutObject", "s3:DeleteObject"]
#     resources = ["arn:aws:s3:::${var.snapshots["bucket_name"]}/${var.snapshots["snapshot_name"]}/*.snap"]
#
#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
#   statement {
#     effect    = "Allow"
#     actions   = ["s3:ListBucketVersions", "s3:ListBucket"]
#     resources = ["arn:aws:s3:::${var.snapshots["bucket_name"]}"]
#
#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

resource "aws_s3_bucket" "bucket" {
  count         = var.serverinfo["count"] >= 1 ? 1 : 0
  bucket        = var.snapshots["bucket_name"]
  acl           = "private"
  region        = var.region
  force_destroy = true

  # policy = "${data.aws_iam_policy_document.s3policy.json}"

  tags = {
    client = lower(var.tags["client"])
  }
}

