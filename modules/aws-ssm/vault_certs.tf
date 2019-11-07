locals {
  vault_root_cert   = "certs/vault_bundle.pem"
  vault_server_cert = "certs/vault_cert.pem"
  vault_server_key  = "certs/vault_cert-key.pem"
}

resource "aws_ssm_parameter" "vault_server_tls_ca_bundle" {
  count     = "${var.https_enabled == 1 ? 1 : 0}"
  name      = "vault_server_tls_ca_bundle"
  type      = "SecureString"
  value     = "${file("${path.module}/../../${local.vault_root_cert}")}"
  key_id    = "${var.key_id}"
  overwrite = true
}

resource "aws_ssm_parameter" "vault_server_tls_cert" {
  count     = "${var.https_enabled == 1 ? 1 : 0}"
  name      = "vault_server_tls_cert"
  type      = "SecureString"
  value     = "${file("${path.module}/../../${local.vault_server_cert}")}"
  key_id    = "${var.key_id}"
  overwrite = true
}

resource "aws_ssm_parameter" "vault_server_tls_key" {
  count     = "${var.https_enabled == 1 ? 1 : 0}"
  name      = "vault_server_tls_key"
  type      = "SecureString"
  value     = "${file("${path.module}/../../${local.vault_server_key}")}"
  key_id    = "${var.key_id}"
  overwrite = true
}
