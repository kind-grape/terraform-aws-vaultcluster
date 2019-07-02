module "initialize" {
  source = "git@github.com:melonger/aws-initialize.git"

  terraform_bucket_name = "${lower(var.tags["client"])}-s3_bucket"
  tags                  = "${var.tags}"
}