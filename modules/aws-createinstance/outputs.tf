output "server_ids" {
  value = "${aws_instance.default.*.id}"
}
