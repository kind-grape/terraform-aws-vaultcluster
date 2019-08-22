output "consul_server_cluster_uuid" {
  value = "${random_uuid.consul_master_key.result}"
}

output "ssm_kms_key_id" {
  value = "${aws_kms_key.ssm.key_id}"
}

output "ssm_parameter_consul_gossip_encryption_key" {
  value = "${aws_ssm_parameter.consul_gossip_encryption_key.id}"
}

output "ssm_parameter_consul_tls_ca_bundle" {
  value = "${aws_ssm_parameter.consul_tls_ca_bundle.id}"
}

output "ssm_parameter_consul_server_tls_cert" {
  value = "${aws_ssm_parameter.consul_server_tls_cert.id}"
}

output "ssm_parameter_consul_server_tls_key" {
  value = "${aws_ssm_parameter.consul_server_tls_key.id}"
}

output "ssm_parameter_consul_client_tls_cert" {
  value = "${aws_ssm_parameter.consul_client_tls_cert.id}"
}

output "ssm_parameter_consul_client_tls_key" {
  value = "${aws_ssm_parameter.consul_client_tls_key.id}"
}

# output "ssm_parameter_vault_server_tls_ca_bundle" {
#   value = "${aws_ssm_parameter.vault_server_tls_ca_bundle.id}"
# }
#
# output "ssm_parameter_vault_server_tls_cert" {
#   value = "${aws_ssm_parameter.vault_server_tls_cert.id}"
# }
#
# output "ssm_parameter_vault_server_tls_key" {
#   value = "${aws_ssm_parameter.vault_server_tls_key.id}"
# }
