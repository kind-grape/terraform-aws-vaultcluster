# data "terraform_remote_state" "setup" {
#   backend = var.backend
#
#   config = {
#     bucket = var.bucket
#     key    = "${upper(local.tags["client"])}/setup/terraform.tfstate"
#     region = var.region
#   }
# }
#
