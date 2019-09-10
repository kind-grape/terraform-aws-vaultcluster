data "aws_iam_policy_document" "s3policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject", "s3:DeleteObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/${var.snapshot_name}/consul-*.snap"]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucketVersions", "s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.bucket_name}"]
  }
}


resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
  acl    = "private"
  region = "${var.region}"

  policy = "${data.aws_iam_policy_document.s3policy.json}"

  tags = {
    client = "${lower(var.tags["client"])}"
  }
}
