# #######################################################
# ## SSM outputs
# #######################################################
output "consul_server_master_token" {
  value = "${module.ssm_data.consul_server_master_token}"
}

# output "ssm_kms_key_id" {
#   value = "${module.ssm_data.ssm_kms_key_id}"
# }

output "ssm_parameter_consul_gossip_encryption_key_id" {
  value = "${module.ssm_data.ssm_parameter_consul_gossip_encryption_key_id}"
}

output "ssm_parameter_consul_tls_ca_bundle" {
  value = "${module.ssm_data.ssm_parameter_consul_tls_ca_bundle}"
}

output "ssm_parameter_consul_server_tls_cert" {
  value = "${module.ssm_data.ssm_parameter_consul_server_tls_cert}"
}

output "ssm_parameter_consul_server_tls_key" {
  value = "${module.ssm_data.ssm_parameter_consul_server_tls_key}"
}

output "ssm_parameter_consul_client_tls_cert" {
  value = "${module.ssm_data.ssm_parameter_consul_client_tls_cert}"
}

output "ssm_parameter_consul_client_tls_key" {
  value = "${module.ssm_data.ssm_parameter_consul_client_tls_key}"
}

# #######################################################
# ## Consul Backend outputs
# #######################################################
output "nsg_consul_storage_name" {
  value = "${module.consul_storage_sg.this_security_group_name}"
}

output "nsg_consul_storage_id" {
  value = "${module.consul_storage_sg.this_security_group_id}"
}

# output "consul_bk_user_data" {
#   value = "${module.consul_bk_user_data.user_data}"
# }

#
# output "consulbk_srv_names" {
#   value = ["${module.consul_backend.server_names}"]
# }

# output "consulbk_srv_ids" {
#   value = ["${module.consul_bk.server_ids}"]
# }

#
# output "consulbk_status" {
#   value = "${module.consul_backend.status}"
# }
#
# #######################################################
# ## Consul SD outputs
# #######################################################
# output "nsg_consulsd_name" {
#   value = "${module.consulsd_sg.this_security_group_name}"
# }
#
# output "nsg_consulsd_id" {
#   value = "${module.consulsd_sg.this_security_group_id}"
# }

# output "consulsd_srv_names" {
#   value = ["${module.consul_sd.server_names}"]
# }

# output "consulsd_srv_ids" {
#   value = ["${module.consul_sd.server_ids}"]
# }

# output "consulsd_status" {
#   value = "${module.consul_sd.status}"
# }
#
# #######################################################
# ## Vault outputs
# #######################################################
output "nsg_vault_name" {
  value = "${module.vault_sg.this_security_group_name}"
}

output "nsg_vault_id" {
  value = "${module.vault_sg.this_security_group_id}"
}

#
# output "vault_srv_names" {
#   value = ["${module.vault.server_names}"]
# }
#
# output "vault_srv_ids" {
#   value = ["${module.vault.server_ids}"]
# }

#
# output "vault_status" {
#   value = "${module.vault.status}"
# }
#
# #######################################################
# ## KMS outputs
# #######################################################
output "kms_arn" {
  value = "${module.kms.kms_arn}"
}

output "kms_id" {
  value = "${module.kms.kms_id}"
}

output "kms_iam_instance_profile" {
  value = "${module.kms.iam_instance_profile}"
}
