terraform {
  backend "s3" {
    bucket = "falcon-tfstate"
    key    = "GWL/env/terraform.tfstate"
    region = "ca-central-1"
  }
}
