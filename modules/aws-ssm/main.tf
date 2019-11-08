resource "random_uuid" "consul_master_key" {}

resource "random_id" "consul_gossip_encryption_key" {
  byte_length = 16
}

resource "aws_ssm_parameter" "master_token" {
  name   = "consul-${var.join_tag}-acl-master"
  type   = "SecureString"
  value  = "${random_uuid.consul_master_key.result}"
  key_id = "${var.key_id}"

  lifecycle {
    ignore_changes = ["value", "description", "key_id"]
  }
}

resource "aws_ssm_parameter" "consul_gossip_encryption_key" {
  name      = "consul_gossip_encryption_key"
  type      = "SecureString"
  value     = "${random_id.consul_gossip_encryption_key.b64_std}"
  key_id    = "${var.key_id}"
  overwrite = true
}
