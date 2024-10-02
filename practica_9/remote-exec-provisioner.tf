resource "aws_instance" "web_server" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.myKey.key_name

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"                       # Usuario predeterminado para Amazon Linux
      private_key = data.aws_key_pair.myKey.key_name # Llave privada para conectarse a la instancia
      host        = self.public_ip
    }

    inline = [
      "apt update -y",
      "apt install -y apache2",   # Instala Apache
      "systemctl start apache2",  # Inicia el servicio Apache
      "systemctl enable apache2", # Habilita Apache para que inicie automáticamente
      "echo '<h1>Bienvenido al servidor web</h1>' | sudo tee /var/www/html/index.html"
    ]
  }

  tags = {
    Name = "Terraform-Web-Server"
  }
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
