resource "local_file" "productos" {
  content  = "Lista de productos para el mes de Septiembre"
  filename = "productos.txt"
}
