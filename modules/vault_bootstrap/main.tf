# data "template_file" "wait" {
#   template = "${file("../scripts/wait_for_vault.sh")}"
# }

# data "template_file" "unseal" {
#   template = "${file("../scripts/unseal.sh")}"
# }

resource "null_resource" "configure_vault" {
  connection {
    host        = "${element(var.vault_ips, 0)}"
    type        = "ssh"
    user        = "${var.os_user}"
    private_key = "${var.ssh_private_key}"
  }

  # provisioner "file" {
  #   source      = "../scripts/unseal.sh"
  #   destination = "/tmp/unseal.sh"
  # }

  # provisioner "file" {
  #   content     = "${data.template_file.wait.rendered}"
  #   destination = "/tmp/wait_for_vault.sh"
  # }

  provisioner "remote-exec" {
    inline = <<EOF
set -x
# sudo chmod +x /tmp/unseal.sh; sudo chmod +x /tmp/wait_for_vault.sh
if ! grep -q '${element(var.consul_data_ips, 0)}' /etc/hosts; then
    echo "Hosts file entry does not Exist"
    echo '${element(var.consul_data_ips, 0)}   consul-vault.service.consul' | sudo tee -a /etc/hosts > /dev/null
fi
EOF
  }

#   provisioner "remote-exec" {
#     inline = <<EOF
# set -x
# sudo service vault start
# EOF
#   }
#
#   provisioner "remote-exec" {
#     inline = <<EOF
# sudo /tmp/wait_for_vault.sh
# EOF
#   }

  provisioner "remote-exec" {
    inline = <<EOF
set -x
sleep 10
sudo /tmp/unseal.sh
cat /tmp/vault_admin_key.txt
EOF
  }
}
