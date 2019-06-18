data "terraform_remote_state" "setup" {
  backend = "${var.backend}"

  config {
    bucket = "${var.bucket}"
    key    = "${upper(var.tags["client"])}/${upper(var.environment)}/terraform.tfstate"
    region = "${var.region}"
  }
}
