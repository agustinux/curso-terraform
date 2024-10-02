resource "aws_s3_bucket" "voxia_bucket" {
    bucket = local.s3-sufix
}