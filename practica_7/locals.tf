locals {
  sufix = "${var.tags.project}-${var.tags.Env}-${var.tags.region}" ## El nombre quedará así: recurso-voxia-Devel-region
}

/*
  Para crear el nombre random del bucket y no pueda ser rechazado porque se repita el nombre
  */
resource "random_string" "sufijo-s3" {
  length = 8
  special = false
  upper = false
}

locals {
  s3-sufix = "${var.tags.project}-${random_string.sufijo-s3.id}"
}