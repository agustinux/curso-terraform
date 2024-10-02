provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web_server" {
  ami           = "ami-2757f631" # Reemplaza con la AMI que desees
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"                 # Usuario predeterminado para Amazon Linux
      private_key = file(var.private_key_path) # Llave privada para conectarse a la instancia
      host        = self.public_ip
    }

    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",   # Instala Apache
      "sudo systemctl start httpd",  # Inicia el servicio Apache
      "sudo systemctl enable httpd", # Habilita Apache para que inicie automáticamente
      "echo '<h1>Bienvenido al servidor web</h1>' | sudo tee /var/www/html/index.html"
    ]
  }

  tags = {
    Name = "Terraform-Web-Server"
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file(var.public_key_path) # Llave pública que usarás para conectarte a la instancia
}

resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permitir acceso SSH desde cualquier IP
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permitir tráfico HTTP desde cualquier IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
