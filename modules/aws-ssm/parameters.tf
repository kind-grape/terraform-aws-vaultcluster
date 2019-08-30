resource "aws_ssm_parameter" "agent_token" {
  name   = "consul-${var.join_tag}-acl-agent"
  type   = "SecureString"
  value  = "REPLACEME"
  key_id = "${var.key_id}"
  # overwrite = true
  lifecycle {
    ignore_changes = ["value", "description", "key_id"]
  }
}

resource "aws_ssm_parameter" "vault_token" {
  name   = "consul-${var.join_tag}-acl-vault"
  type   = "SecureString"
  value  = "REPLACEME"
  key_id = "${var.key_id}"
  # overwrite = true

  lifecycle {
    ignore_changes = ["value", "description", "key_id"]
  }
}
