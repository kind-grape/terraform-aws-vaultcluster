resource "random_uuid" "consul_master_key" {}

resource "random_id" "consul_gossip_encryption_key" {
  byte_length = 16
}

resource "aws_kms_key" "ssm" {
  description             = "Vault and Consul SSM Parameters KMS Key"
  deletion_window_in_days = "${var.ssm_kms_deletion_days}"
  enable_key_rotation     = "${var.ssm_kms_key_rotate}"

  tags {
    "Name" = "${var.namespace}-vault-ssm-kms"
  }
}

resource "aws_kms_alias" "ssm" {
  name          = "alias/${var.namespace}-vault-ssm"
  target_key_id = "${aws_kms_key.ssm.key_id}"
}

resource "aws_ssm_parameter" "master_token" {
  name   = "/${var.namespace}-vault/consul-${var.join_tag}-acl-master"
  type   = "SecureString"
  value  = "${random_id.consul_gossip_encryption_key.b64_std}"
  key_id = "${aws_kms_key.ssm.key_id}"
}

resource "aws_ssm_parameter" "consul_gossip_encryption_key" {
  name   = "/${var.namespace}-vault/consul_gossip_encryption_key"
  type   = "SecureString"
  value  = "${random_id.consul_gossip_encryption_key.b64_std}"
  key_id = "${aws_kms_key.ssm.key_id}"
}

# NOTE: The Consul server and client certificates must both be signed by the same CA
resource "aws_ssm_parameter" "consul_tls_ca_bundle" {
  name   = "/${var.namespace}-vault/consul_tls_ca_bundle"
  type   = "SecureString"
  value  = "${base64encode(file("${path.module}/../../certs/consul-agent-ca.pem"))}"
  key_id = "${aws_kms_key.ssm.key_id}"
}

resource "aws_ssm_parameter" "consul_server_tls_cert" {
  name   = "/${var.namespace}-vault/consul_server_tls_cert"
  type   = "SecureString"
  value  = "${base64encode(file("${path.module}/../../certs/${var.region}-server-consul-0.pem"))}"
  key_id = "${aws_kms_key.ssm.key_id}"
}

resource "aws_ssm_parameter" "consul_server_tls_key" {
  name   = "/${var.namespace}-vault/consul_server_tls_key"
  type   = "SecureString"
  value  = "${base64encode(file("${path.module}/../../certs/${var.region}-server-consul-0-key.pem"))}"
  key_id = "${aws_kms_key.ssm.key_id}"
}

resource "aws_ssm_parameter" "consul_client_tls_cert" {
  name   = "/${var.namespace}-vault/consul_client_tls_cert"
  type   = "SecureString"
  value  = "${base64encode(file("${path.module}/../../certs/${var.region}-client-consul-0.pem"))}"
  key_id = "${aws_kms_key.ssm.key_id}"
}

resource "aws_ssm_parameter" "consul_client_tls_key" {
  name   = "/${var.namespace}-vault/consul_client_tls_key"
  type   = "SecureString"
  value  = "${base64encode(file("${path.module}/../../certs/${var.region}-client-consul-0-key.pem"))}"
  key_id = "${aws_kms_key.ssm.key_id}"
}

# resource "aws_ssm_parameter" "vault_server_tls_ca_bundle" {
#   name   = "/${var.namespace}-vault/vault_server_tls_ca_bundle"
#   type   = "SecureString"
#   value  = "${base64encode(file("${path.module}/../../files/${var.environment}/vault_server_ca_bundle.pem"))}"
#   key_id = "${aws_kms_key.ssm.key_id}"
# }
#
# resource "aws_ssm_parameter" "vault_server_tls_cert" {
#   name   = "/${var.namespace}-vault/vault_server_tls_cert"
#   type   = "SecureString"
#   value  = "${base64encode(file("${path.module}/../../files/${var.environment}/vault_server_cert.pem"))}"
#   key_id = "${aws_kms_key.ssm.key_id}"
# }
#
# resource "aws_ssm_parameter" "vault_server_tls_key" {
#   name   = "/${var.namespace}-vault/vault_server_tls_key"
#   type   = "SecureString"
#   value  = "${base64encode(file("${path.module}/../../files/${var.environment}/vault_server_key.pem"))}"
#   key_id = "${aws_kms_key.ssm.key_id}"
# }
