output "user_data" {
  value = data.template_file.user_data.rendered
}

output "user_data_base64" {
  value = data.template_cloudinit_config.user_data.rendered
}
