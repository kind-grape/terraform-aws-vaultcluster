resource "aws_ssm_parameter" "agent_token" {
  name   = "consul-client-agent-token"
  type   = "SecureString"
  value  = random_uuid.consul_client_agent_token.result
  key_id = var.key_id

  # overwrite = true
  lifecycle {
    ignore_changes = [
      value,
      description,
      key_id,
    ]
  }
}

resource "aws_ssm_parameter" "vault_token" {
  name   = "consul-vault-token"
  type   = "SecureString"
  value  = random_uuid.consul_vault_token.result
  key_id = var.key_id

  # overwrite = true

  lifecycle {
    ignore_changes = [
      value,
      description,
      key_id,
    ]
  }
}

resource "aws_ssm_parameter" "default_token" {
  name   = "consul-default-token"
  type   = "SecureString"
  value  = random_uuid.consul_default_token.result
  key_id = var.key_id

  # overwrite = true

  lifecycle {
    ignore_changes = [
      value,
      description,
      key_id,
    ]
  }
}

resource "aws_ssm_parameter" "snapshot_token" {
  name   = "consul-snapshot-token"
  type   = "SecureString"
  value  = random_uuid.consul_snapshot_token.result
  key_id = var.key_id

  # overwrite = true

  lifecycle {
    ignore_changes = [
      value,
      description,
      key_id,
    ]
  }
}

resource "aws_ssm_parameter" "vaultkey" {
  count  = var.vault_recovery_shares >= 1 ? var.vault_recovery_shares : 0
  name   = "vault_recovery_share_${count.index}"
  type   = "SecureString"
  value  = "REPLACEME"
  key_id = var.key_id

  lifecycle {
    ignore_changes = [
      value,
      description,
      key_id,
    ]
  }
}
