locals {
  root_cert = "certs/consul-agent-ca.pem"
  server_cert = "certs/${var.region}-server-consul-0.pem"
  server_key = "certs/${var.region}-server-consul-0-key.pem"
  client_cert = "certs/${var.region}-client-consul-0.pem"
  client_key = "certs/${var.region}-client-consul-0-key.pem"
}

resource "random_uuid" "consul_master_key" {}

resource "random_id" "consul_gossip_encryption_key" {
  byte_length = 16
}

resource "aws_ssm_parameter" "master_token" {
  name   = "consul-${var.join_tag}-acl-master"
  type   = "SecureString"
  value  = "${random_uuid.consul_master_key.result}"
  key_id = "${var.key_id}"
  overwrite = true
}

resource "aws_ssm_parameter" "agent_token" {
  name   = "consul-${var.join_tag}-acl-agent"
  type   = "SecureString"
  value  = "REPLACEME"
  key_id = "${var.key_id}"
  # overwrite = true
}

resource "aws_ssm_parameter" "vault_token" {
  name   = "consul-${var.join_tag}-acl-vault"
  type   = "SecureString"
  value  = "REPLACEME"
  key_id = "${var.key_id}"
  # overwrite = true
}

resource "aws_ssm_parameter" "consul_gossip_encryption_key" {
  name   = "consul_gossip_encryption_key"
  type   = "SecureString"
  value  = "${random_id.consul_gossip_encryption_key.b64_std}"
  key_id = "${var.key_id}"
  overwrite = true
}

# NOTE: The Consul server and client certificates must both be signed by the same CA
resource "aws_ssm_parameter" "consul_tls_ca_bundle" {
  name   = "consul_tls_ca_bundle"
  type   = "SecureString"
  value  = "${file("${path.module}/../../${local.root_cert}")}"
  key_id = "${var.key_id}"
  overwrite = true
}

resource "aws_ssm_parameter" "consul_server_tls_cert" {
  name   = "consul_server_tls_cert"
  type   = "SecureString"
  value  = "${file("${path.module}/../../${local.server_cert}")}"
  key_id = "${var.key_id}"
  overwrite = true
}

resource "aws_ssm_parameter" "consul_server_tls_key" {
  name   = "consul_server_tls_key"
  type   = "SecureString"
  value  = "${file("${path.module}/../../${local.server_key}")}"
  key_id = "${var.key_id}"
  overwrite = true
}

resource "aws_ssm_parameter" "consul_client_tls_cert" {
  name   = "consul_client_tls_cert"
  type   = "SecureString"
  value  = "${file("${path.module}/../../${local.client_cert}")}"
  key_id = "${var.key_id}"
  overwrite = true
}

resource "aws_ssm_parameter" "consul_client_tls_key" {
  name   = "consul_client_tls_key"
  type   = "SecureString"
  value  = "${file("${path.module}/../../${local.client_key}")}"
  key_id = "${var.key_id}"
  overwrite = true
}

# resource "aws_ssm_parameter" "vault_server_tls_ca_bundle" {
#   name   = "vault_server_tls_ca_bundle"
#   type   = "SecureString"
#   value  = "${base64encode(file("${path.module}/../../files/${var.environment}/vault_server_ca_bundle.pem"))}"
#   key_id = "${var.key_id}"
# }
#
# resource "aws_ssm_parameter" "vault_server_tls_cert" {
#   name   = "vault_server_tls_cert"
#   type   = "SecureString"
#   value  = "${base64encode(file("${path.module}/../../files/${var.environment}/vault_server_cert.pem"))}"
#   key_id = "${var.key_id}"
# }
#
# resource "aws_ssm_parameter" "vault_server_tls_key" {
#   name   = "vault_server_tls_key"
#   type   = "SecureString"
#   value  = "${base64encode(file("${path.module}/../../files/${var.environment}/vault_server_key.pem"))}"
#   key_id = "${var.key_id}"
# }
