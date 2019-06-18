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

# data "template_file" "chef" {
#   template = "${var.chef_envfile}"
#
#   vars {
#     autojoin        = "${var.serverinfo["autojoin"]}"
#     tlslistener     = "${var.serverinfo["tlslistener"]}"
#     enterprise      = "${var.serverinfo["enterprise"]}"
#     enablesyslog    = "${var.serverinfo["enablesyslog"]}"
#     ui              = "${var.serverinfo["ui"]}"
#     tfproject       = "${var.project}"
#     region          = "${var.region}"
#     env             = "${var.env}"
#     sdtag           = "${var.sdtag}"
#     datatag         = "${var.datatag}"
#     sdsrvnodes      = "${var.sdsrvnodes}"
#     datasrvnodes    = "${var.datasrvnodes}"
#     sdenckey        = "${var.sdenckey}"
#     dataenckey      = "${var.dataenckey}"
#     key_ring        = "${var.key_ring}"
#     crypto_key      = "${var.crypto_key}"
#     seal            = "${var.seal}"
#   }
# }

resource "null_resource" "configure_vault" {
  count = "${var.serverinfo["count"]}"

  connection {
    host        = "${var.vault_ips[count.index]}"
    type        = "ssh"
    user        = "${var.os_user}"
    private_key = "${var.ssh_private_key}"
  }

  provisioner "file" {
    content     = "${data.template_file.chef.rendered}"
    destination = "/home/chef/.chef/environments/${var.env}.json"
  }

  provisioner "remote-exec" {
    inline = <<EOF
set -x
if [ -f '/etc/${var.serverinfo["role"]}.d/${var.serverinfo["role"]}.hcl' ]; then
  echo '${var.serverinfo["role"]}.hcl already exists, skipping...'
else
  until [ -e /tmp/chef_done ]; do
    echo "Chef not setup yet.. Trying in 2 seconds"
    sleep 2
  done
  sudo chef-client -E ${var.env} -o role[${var.serverinfo["role"]}]
fi
EOF
  }

  # provisioner "file" {
  #   content     = "${data.template_file.consul.rendered}"
  #   destination = "/tmp/certs_consul.sh"
  # }
  #
  # provisioner "file" {
  #   content     = "${data.template_file.vault.rendered}"
  #   destination = "/tmp/certs_vault.sh"
  # }

#   provisioner "remote-exec" {
#     inline = <<EOF
# set -x
# sudo chmod +x /bin/wait_for_consul.sh; sudo chmod +x /tmp/certs_vault.sh; sudo /tmp/certs_vault.sh
# sudo chmod +x /tmp/certs_consul.sh; sudo /tmp/certs_consul.sh
# echo 'Setting Encryption'
# sudo sed -i 's/dc1/${local.datacenter}/g' /etc/consul/consul.hcl
# sudo sed -i 's/REPLACEKEY/${var.sdenckey}/g' /etc/consul/consul.hcl
# sudo sed -i 's/REPLACE_JOIN/provider=gce project_name=${var.project} tag_value=${var.sdtag}/g' /etc/consul/consul.hcl
# EOF
#   }

#   provisioner "remote-exec" {
#     inline = <<EOF
# set -x
# sudo service consulagent start
# sudo wait_for_consul.sh
# EOF
#   }

#   provisioner "remote-exec" {
#     inline = <<EOF
# set -x
# echo 'Configuring Seal'
# sudo sed -i 's/vaultprojectREPLACE/${var.project}/g' /etc/${var.serverinfo["role"]}.d/${var.serverinfo["role"]}.hcl
# sudo sed -i 's/regionREPLACE/${var.region}/g' /etc/${var.serverinfo["role"]}.d/${var.serverinfo["role"]}.hcl
# sudo sed -i 's/vaultkeyringREPLACE/${var.key_ring}/g' /etc/${var.serverinfo["role"]}.d/${var.serverinfo["role"]}.hcl
# sudo sed -i 's/vaultkeyREPLACE/${var.crypto_key}/g' /etc/${var.serverinfo["role"]}.d/${var.serverinfo["role"]}.hcl
# EOF
#   }
}
