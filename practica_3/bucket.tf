resource "aws_s3_bucket" "proveedores" {
  count = 6
  bucket = "cun-proveedores-${random_string.sufijo[count.index].id}"
  tags = {
    Owner = "AgusTinux"
    Environment = "Dev"
    Office = "Proveedores"
  }
}

resource "random_string" "sufijo" {
  count   = 6
  length  = 8
  special = false
  upper   = false
  numeric = false
}