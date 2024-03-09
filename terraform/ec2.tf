data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_instance" "ashuos1" {

    ami = data.aws_ami.latest_amazon_linux.id
    key_name = "ashu-pcs"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    
    user_data = <<EOF
                #!/bin/bash
                yum install httpd -y
                echo "Hello terraform !!" >/var/www/html/index.html
                systemctl enable --now httpd
                EOF
    
    tags = {
      "Name" = "fully-vpc-Instances"
    }
}