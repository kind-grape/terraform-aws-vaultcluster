# #######################################################
# ## SSM outputs
# #######################################################
output "ssm_parameters" {
  value = {
    consul_server_master_token = module.ssm_data.consul_server_master_token
    ssm_parameter_consul_gossip_encryption_key_id = module.ssm_data.ssm_parameter_consul_gossip_encryption_key_id
    ssm_parameter_consul_tls_ca_bundle = module.ssm_data.ssm_parameter_consul_tls_ca_bundle
    ssm_parameter_consul_server_tls_cert = module.ssm_data.ssm_parameter_consul_server_tls_cert
    ssm_parameter_consul_server_tls_key = module.ssm_data.ssm_parameter_consul_server_tls_key
    ssm_parameter_consul_client_tls_cert = module.ssm_data.ssm_parameter_consul_client_tls_cert
    ssm_parameter_consul_client_tls_key = module.ssm_data.ssm_parameter_consul_client_tls_key
    # ssm_kms_key_id = module.ssm_data.ssm_kms_key_id
  }
}

# #######################################################
# ## Consul Backend outputs
# #######################################################

output "consul_storage" {
  value = {
    nsg_consul_storage_name = module.consul_storage_sg.this_security_group_name
    nsg_consul_storage_id = module.consul_storage_sg.this_security_group_id
    # consul_bk_user_data = module.consul_bk_user_data.user_data
    # consulbk_srv_names = module.consul_storage.server_names
    # consulbk_srv_ids = module.consul_storage.server_ids
    # consulbk_status = module.consul_storage.status
  }
}

# #######################################################
# ## Consul SD outputs
# #######################################################
output "consul_sd" {
  value = {
    nsg_consulsd_name = module.consul_storage_sg.this_security_group_name
    nsg_consulsd_id = module.consul_storage_sg.this_security_group_id
    # consulsd_user_data = module.consul_sd_user_data.user_data
    # consulsd_srv_names = module.consul_sd.server_names
    # consulsd_srv_ids = module.consul_sd.server_ids
    # consulsd_status = module.consul_sd.status
  }
}

# #######################################################
# ## Consul Snapshot outputs
# #######################################################
output "consul_snapshot" {
  value = {
    nsg_consul_snapshot_name = module.consul_snap_sg.this_security_group_name
    nsg_consul_snapshot_id = module.consul_snap_sg.this_security_group_id
  }
}

# #######################################################
# ## Vault outputs
# #######################################################
output "vault" {
  value = {
    nsg_vault_name = module.vault_sg.this_security_group_name
    nsg_vault_id = module.vault_sg.this_security_group_id
  }
}

# #######################################################
# ## KMS outputs
# #######################################################
output "kms" {
  value = {
    kms_arn = module.kms.kms_arn
    kms_id = module.kms.kms_id
    kms_iam_instance_profile = module.kms.iam_instance_profile
  }
}

# #######################################################
# ## S3 outputs
# #######################################################
output "s3" {
  value = {
    s3_arn = module.consul_snapshot_s3.arn
    s3_id = module.consul_snapshot_s3.id
    s3_domain_name = module.consul_snapshot_s3.bucket_domain_name
  }
}
