data "template_file" "user_data_consul" {
  count    = "${var.serverinfo["role"] == "consul" && var.serverinfo["count"] >= 1 ? 1 : 0}"
  template = "${file("var.user_data")}"
  vars = {
    consul_bootstrap_expect = "${var.serverinfo["count"]}"
    consul_join_tag_value = "${var.tags["auto_join"]}"
    consul_join_region = "${var.region}"
    consul_server_rpc_port = "${var.consul_bk_ports["server_rpc_port"]}"
    consul_serf_lan_port = "${var.consul_bk_ports["serf_lan_port"]}"
    consul_serf_wan_port = "${var.consul_bk_ports["serf_wan_port"]}"
    consul_http_port = "${var.consul_bk_ports["http_port"]}"
    consul_https_port = "${var.consul_bk_ports["https_port"]}"
    consul_dns_port = "${var.consul_bk_ports["dns_port"]}"
    consul_encryption_key = "${var.serverinfo["masterkey"]}"
    # consul_agent_policy_name = "${aws_instance.consul.private_ip}"
    # consul_application_policy_name = "${aws_instance.consul.private_ip}"
  }
}

data "template_file" "user_data_vault" {
  count    = "${var.serverinfo["role"] == "vault" && var.serverinfo["count"] >= 1 ? 1 : 0}"
  template = "${file("var.user_data")}"
  vars = {
    # consul_bootstrap_expect = "${aws_instance.vault.private_ip}"
    # vault_join_tag_key = "${aws_instance.vault.private_ip}"
    # vault_join_tag_value = "${aws_instance.vault.private_ip}"
    # vault_join_region = "${aws_instance.vault.private_ip}"
    # vault_server_rpc_port = "${aws_instance.vault.private_ip}"
    # vault_serf_lan_port = "${aws_instance.vault.private_ip}"
    # vault_serf_wan_port = "${aws_instance.vault.private_ip}"
    # vault_http_port = "${aws_instance.vault.private_ip}"
    # vault_https_port = "${aws_instance.vault.private_ip}"
    # vault_dns_port = "${aws_instance.vault.private_ip}"
    # vault_encryption_key = "${aws_instance.vault.private_ip}"
    # vault_agent_policy_name = "${aws_instance.vault.private_ip}"
    # vault_application_policy_name = "${aws_instance.vault.private_ip}"
  }
}

resource "aws_instance" "default" {
  count         = "${var.serverinfo["count"] >= 1 ? var.serverinfo["count"] : 0}"
  ami           = "${var.serverinfo["ami"]}"
  instance_type = "${var.serverinfo["size"]}"
  key_name      = "${var.key_name}"

  user_data     = "${var.serverinfo["role"] == "consul" ? data.template_file.user_data_consul.rendered : data.template_file.user_data_vault.rendered}"

  vpc_security_group_ids = ["${var.security_groups}"]
  subnet_id              = "${var.subnet_id}"

  root_block_device = {
    volume_size           = "${var.serverinfo["root_size"]}"
    delete_on_termination = true
    volume_type           = "${var.serverinfo["root_type"]}"
  }

  tags = {
    Name   = "${var.hostname}${count.index}"
    client = "${var.tags["client"]}"
  }
}
