output "user_data" {
  value = "${data.template_file.user_data.0.rendered}"
}
