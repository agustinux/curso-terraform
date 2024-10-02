variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
  /* type = map(string) */
}

/* variable "public_subnet" {
  description = "CIDR public subnet"
  type = string
}

variable "private_subnet" {
  description = "CIDR private subnet"
  type = string
 } */

variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags del pŕoyecto"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type = string

}

variable "ec2_specs" {
  description = "Parametros de la Instancia"
  type = map(string)
}

variable "enable_monitor" {
  description = "Habilita/Deshabilita el despliegue de un servidor de monitoreo"
  // type = bool ## Puede ser boolena
  type = number ## Numérica
}

variable "ingress_port_list" {
  description = "Lista de puertos de Igress"
  type = list(number)
}