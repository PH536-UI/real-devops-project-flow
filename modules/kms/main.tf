resource "aws_kms_key" "this" {
  deletion_window_in_days = 7
}

output "key_arn" {
  value = aws_kms_key.this.arn
}
