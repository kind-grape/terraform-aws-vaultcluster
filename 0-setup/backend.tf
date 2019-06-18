terraform {
  backend "s3" {
    bucket = "falcon-tfstate"
    key    = "GWL/setup/terraform.tfstate"
    region = "ca-central-1"
  }
}
