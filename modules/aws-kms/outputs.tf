output "kms_id" {
  value = "${aws_kms_key.key.key_id}"
}

output "kms_arn" {
  value = "${aws_kms_key.key.arn}"
}

output "iam_instance_profile" {
  value = "${aws_iam_instance_profile.instance_profile.id}"
}
