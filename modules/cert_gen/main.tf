data "template_file" "generate_consul_certs" {
  template = file("${path.module}/../../scripts/generate_consul_certs.sh")
  vars = {
    region  = var.region
    tempdir = "${path.module}/../../certs"
  }
}

resource "null_resource" "generate_consul_certs" {
  provisioner "local-exec" {
    command = data.template_file.generate_consul_certs.rendered
  }
}

data "template_file" "generate_vault_ca" {
  template = file("${path.module}/../../scripts/cert.sh")
  vars = {
    domain   = var.domain
    dc       = var.certs["DC"]
    country  = var.certs["COUNTRY"]
    state    = var.certs["STATE"]
    location = var.certs["LOCATION"]
    org      = var.certs["ORG"]
    ou       = var.certs["OU"]
    tempdir  = "${path.module}/../../certs"
  }
}

resource "null_resource" "generate_vault_ca" {
  provisioner "local-exec" {
    command = data.template_file.generate_vault_ca.rendered
  }
}

variable "module_depends_on" {
  type    = any
  default = "created"
}
