output "user_data" {
  value = "${data.template_file.user_data.0.rendered}"
}

output "user_data_base64" {
  value = "${data.template_cloudinit_config.user_data.0.rendered}"
}
