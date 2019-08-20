data "aws_ami" "vault" {
  most_recent = true
  owners      = ["${var.ami_owner_account}"]
  name_regex  = "amz2-vault-ent-${var.vault["version"]}-*"

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "consul" {
  most_recent = true
  owners      = ["${var.ami_owner_account}"]
  name_regex  = "amz2-consul-ent-${var.consul_storage["version"]}-*"

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
