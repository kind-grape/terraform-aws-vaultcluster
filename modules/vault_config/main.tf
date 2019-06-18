locals {
  datacenter = "${var.serverinfo["datacenter_consul"]}-${var.env}"
}

# data "template_file" "vault" {
#   template = "${file("../scripts/certs.sh")}"
#
#   vars {
#     role      = "vault"
#     region    = "${var.serverinfo["datacenter"]}"
#     env       = "${var.env}"
#   }
# }
#
# data "template_file" "consul" {
#   template = "${file("../scripts/certs.sh")}"
#
#   vars {
#     role      = "consul"
#     region    = "${var.serverinfo["datacenter_consul"]}"
#     env       = "${var.env}"
#   }
# }

data "template_file" "boostrap" {
  template = "${var.playfile}"

  vars {
    masterkey        = "${var.masterkey}"
  }
}

resource "null_resource" "configure_vault" {
  count = "${var.serverinfo["count"]}"

  connection {
    host        = "${var.vault_ips[count.index]}"
    type        = "ssh"
    user        = "${var.os_user}"
    private_key = "${var.ssh_private_key}"
  }

  provisioner "file" {
    content     = "${data.template_file.boostrap.rendered}"
    destination = "/tmp/consul-ansible/boostrap.yml"
  }

  provisioner "remote-exec" {
    inline = <<EOF
set -x
sudo ansible boostrap.yml
fi
EOF
  }
}
