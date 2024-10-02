#ami-0230bd60aa48260c6

resource "aws_instance" "public_instance" {
  ami           = var.ec2_specs.ami
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.myKey.key_name
  vpc_security_group_ids = [ aws_security_group.sg_public_instance.id ]
  user_data = file("userdata.sh")

  # lifecycle {
    # prevent_destroy = true
    # ignore_changes = [ 
    #  ami
    # ]
    # create_before_destroy = true
    # replace_triggered_by = [ aws_subnet.private_subnet.id ]
  # }

  provisioner "local-exec" {
    when = create
    command = "echo Instancia creadad con IP ${self.public_ip} >> datos_instancia.txt"  
  }

  provisioner "local-exec" {
    when = destroy
    command = "echo Instancia ${self.public_ip} Destruida >> datos_instancia.txt"
  }
}
  /* provisioner "remote-exec" {
    inline = [ 
      "echo 'Hola Mundo' > ~/saludo.txt"
     ]

     connection {
       type = "ssh"
       host = self.public_ip
       user = "ec2-user"
       private_key = file("mykey.pem") 
     }
  } */


/*
# Práctica de importación de un recurso
# aws_instance.mywebserver:
resource "aws_instance" "mywebserver" {
    ami                                  = "ami-066784287e358dad1"
    instance_type                        = "t2.micro"
    key_name                             = data.aws_key_pair.myKey.key_name
    subnet_id                            = aws_subnet.public_subnet.id
    tags                                 = {
        "Name" = "my-web-server"
    }
    vpc_security_group_ids               = [
        aws_security_group.sg_public_instance.id,
    ]
}
*/