locals {
  root_cert   = "certs/consul-agent-ca.pem"
  server_cert = "certs/${var.region}-server-consul-0.pem"
  server_key  = "certs/${var.region}-server-consul-0-key.pem"
  client_cert = "certs/${var.region}-client-consul-0.pem"
  client_key  = "certs/${var.region}-client-consul-0-key.pem"
}

# NOTE: The Consul server and client certificates must both be signed by the same CA
resource "aws_ssm_parameter" "consul_tls_ca_bundle" {
  name      = "consul_tls_ca_bundle"
  type      = "SecureString"
  value     = "${file("${path.module}/../../${local.root_cert}")}"
  key_id    = "${var.key_id}"
  overwrite = true
}

resource "aws_ssm_parameter" "consul_server_tls_cert" {
  name      = "consul_server_tls_cert"
  type      = "SecureString"
  value     = "${file("${path.module}/../../${local.server_cert}")}"
  key_id    = "${var.key_id}"
  overwrite = true
}

resource "aws_ssm_parameter" "consul_server_tls_key" {
  name      = "consul_server_tls_key"
  type      = "SecureString"
  value     = "${file("${path.module}/../../${local.server_key}")}"
  key_id    = "${var.key_id}"
  overwrite = true
}

resource "aws_ssm_parameter" "consul_client_tls_cert" {
  name      = "consul_client_tls_cert"
  type      = "SecureString"
  value     = "${file("${path.module}/../../${local.client_cert}")}"
  key_id    = "${var.key_id}"
  overwrite = true
}

resource "aws_ssm_parameter" "consul_client_tls_key" {
  name      = "consul_client_tls_key"
  type      = "SecureString"
  value     = "${file("${path.module}/../../${local.client_key}")}"
  key_id    = "${var.key_id}"
  overwrite = true
}
