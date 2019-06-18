# #######################################################
# ## Consul Backend outputs
# #######################################################
output "nsg_consulbk_name" {
  value = "${module.consulbk_sg.this_security_group_name}"
}

output "nsg_consulbk_id" {
  value = "${module.consulbk_sg.this_security_group_id}"
}
#
# output "consulbk_srv_names" {
#   value = ["${module.consul_backend.server_names}"]
# }

output "consulbk_srv_ids" {
  value = ["${module.consul_bk.server_ids}"]
}
#
# output "consulbk_status" {
#   value = "${module.consul_backend.status}"
# }
#
# #######################################################
# ## Consul SD outputs
# #######################################################
output "nsg_consulsd_name" {
  value = "${module.consulsd_sg.this_security_group_name}"
}

output "nsg_consulsd_id" {
  value = "${module.consulsd_sg.this_security_group_id}"
}

# output "consulsd_srv_names" {
#   value = ["${module.consul_sd.server_names}"]
# }

output "consulsd_srv_ids" {
  value = ["${module.consul_sd.server_ids}"]
}

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
output "vault_srv_ids" {
  value = ["${module.vault.server_ids}"]
}
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
