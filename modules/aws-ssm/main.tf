resource "random_uuid" "consul_master_token" {}
resource "random_uuid" "consul_client_agent_token" {}
resource "random_uuid" "consul_vault_token" {}
resource "random_uuid" "consul_default_token" {}
resource "random_uuid" "consul_snapshot_token" {}

resource "random_id" "consul_gossip_encryption_key" {
  byte_length = 32
}

resource "aws_ssm_parameter" "master_token" {
  name   = "consul-master-token"
  type   = "SecureString"
  value  = random_uuid.consul_master_token.result
  key_id = var.key_id

  lifecycle {
    ignore_changes = [
      value,
      description,
      key_id,
    ]
  }
}

resource "aws_ssm_parameter" "consul_gossip_encryption_key" {
  name      = "consul_gossip_encryption_key"
  type      = "SecureString"
  value     = random_id.consul_gossip_encryption_key.b64_std
  key_id    = var.key_id
  overwrite = true
}
