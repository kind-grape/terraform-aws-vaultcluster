output "arn" {
  value = "${aws_s3_bucket.bucket.*.arn}"
}

output "id" {
  value = "${aws_s3_bucket.bucket.*.id}"
}

output "bucket_domain_name" {
  value = "${aws_s3_bucket.bucket.*.bucket_domain_name}"
}
