output "server_ids" {
  value = "${aws_instance.default.*.id}"
}

output "server_pubips" {
  value = "${aws_instance.default.*.public_ip}"
}
