resource "aws_instance" "default" {
  count         = "${var.serverinfo["count"] >= 1 ? var.serverinfo["count"] : 0}"
  ami           = "${var.serverinfo["ami"]}"
  instance_type = "${var.serverinfo["size"]}"
  key_name      = "${var.key_name}"

  user_data = "${var.user_data}"

  vpc_security_group_ids = ["${var.security_groups}"]
  subnet_id              = "${var.subnet_id}"

  root_block_device = {
    volume_size           = "${var.serverinfo["root_size"]}"
    delete_on_termination = true
    volume_type           = "${var.serverinfo["root_type"]}"
  }

  tags = {
    Name      = "${var.hostname}${count.index}"
    client    = "${var.tags["client"]}"
    auto_join = "${replace(var.tags["auto_join"], "AUTOJOIN", var.serverinfo["role"])}"
  }
}
