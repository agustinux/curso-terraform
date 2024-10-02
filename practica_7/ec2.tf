#ami-0230bd60aa48260c6

## Para asignar el nombre de las instancias
variable "nom_instancias" {
  description = "Nombre de las instancias"
  // type = list(string) ## Para usar con count
  // type = set(string)
  type    = list(string)
  default = ["apache"]
}

## Crea las instancias
resource "aws_instance" "public_instance" {
  // count = length(var.nom_instancias) // Toma la longitud de la variable 
  for_each               = toset(var.nom_instancias)
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.myKey.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")

  tags = {
    // "Name" = var.nom_instancias[count.index]
    "Name" = "${each.value}-${local.sufix}"
  }
}

## Crea instancia de monitoreo
resource "aws_instance" "public_mon_instance" {
  // count         = var.enable_monitor ? 1 : 0 ## Condición IF cuando es booleana
  count                  = var.enable_monitor == 1 ? 1 : 0 ## Condición IF cuando es numérica
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.myKey.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")

  tags = {
    "Name" = "Monitoreo-${local.sufix}"
  }

  # lifecycle {
  # prevent_destroy = true
  # ignore_changes = [ 
  #  ami
  # ]
  # create_before_destroy = true
  # replace_triggered_by = [ aws_subnet.private_subnet.id ]
  # }
}

/* Variables creadas para la explicación de las funciones
variable "cadena" {
  type = string
  default = "ami-123,AMI-AAV,ami-12f"
  
}

variable "palabras" {
  type = list(string)
  default = [ "hola", "que tal","como estan" ]
}

variable "entornos" {
  type = map(string)
  default = {
    "prod" = "10.10.0.0/16"
    "dev" = "172.16.0.0/16"
  }
}
*/
