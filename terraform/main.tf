resource "aws_s3_bucket" "static-site-bucket" {
  bucket = var.bucket_name 
}
