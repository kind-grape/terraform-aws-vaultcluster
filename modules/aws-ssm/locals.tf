locals {
  serverinfo = merge(var.custom_serverinfo, var.serverinfo)
  root_cert   = "certs/consul-agent-ca.pem"
  server_cert = "certs/${var.region}-server-consul-0.pem"
  server_key  = "certs/${var.region}-server-consul-0-key.pem"
  client_cert = "certs/${var.region}-client-consul-0.pem"
  client_key  = "certs/${var.region}-client-consul-0-key.pem"
  vault_root_cert   = "certs/vault_bundle.pem"
  vault_server_cert = "certs/vault_cert.pem"
  vault_server_key  = "certs/vault_cert-key.pem"
}
