resource "local_file" "productos" {
  count = 3
  content = "Lista de productos para el mes de Septiembre"
  filename = "productos-${random_string.sufijo[count.index].id}.txt"
}

resource "random_string" "sufijo" {
  count   = 3
  length  = 4
  special = false
  upper   = false
  numeric = false
}