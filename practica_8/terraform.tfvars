virginia_cidr = "10.10.0.0/16"
/*
virginia_cidr = {
  "prod" = "10.10.0.0/16"
  "devel" = "172.16.0.0/16"
}
*/
subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "Env"         = "Devel"
  "Owner"       = "AgusTinux"
  "Cloud"       = "AWS"
  "IaC"         = "Terraform"
  "IaC_Version" = "v1.6.5"
  "project"     = "voxia"
  "region"      = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami"           = "ami-0230bd60aa48260c6"
  "instance_type" = "t2.micro"
}

ingress_port_list = [22, 80, 443]

// enable_monitor = false ## Cuando es booleana true|false
enable_monitor = 0 // Numérica
