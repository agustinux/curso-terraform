 #!/bin/bash
echo "Este es un mensaje" > ~/mensaje.txt
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd