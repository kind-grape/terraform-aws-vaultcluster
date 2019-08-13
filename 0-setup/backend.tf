terraform {
  backend "s3" {
    bucket = "falcon-tfstate"
    key    = "CLIENT/setup/terraform.tfstate"
    region = "ca-central-1"
  }
}
