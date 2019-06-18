data "terraform_remote_state" "setup" {
  backend = "${var.backend}"

  config {
    bucket = "${var.bucket}"
    key    = "${upper(var.tags["client"])}/setup/terraform.tfstate"
    region = "${var.region}"
  }
}

data "terraform_remote_state" "env" {
  backend = "${var.backend}"

  config {
    bucket = "${var.bucket}"
    key    = "${upper(var.tags["client"])}/${var.environment}/terraform.tfstate"
    region = "${var.region}"
  }
}
