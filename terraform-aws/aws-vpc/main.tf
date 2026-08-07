# create a VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name = "Dev-VPC"
    }
}

# Creating the igw
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "Dev-igw"
    }
}

# Create public subnet

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
    tags = {
      Name = "Dev-Public-Subnet"

    }
}

# Create a Route table for public subnet

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }

    tags = {
      Name = "Dev-Public-RT"

    }
  
}

# Associate rt with the subnet

resource "aws_route_table_association" "public_rt_assoc" {

subnet_id = aws_subnet.public_subnet.id
route_table_id = aws_route_table.public_rt.id
}

# Create the Security group for the web server

resource "aws_security_group" "web_sg" {
name = "dev_web_sg"
description = "Allow HTTP and ssh inbound traffic"
vpc_id = aws_vpc.my_vpc.id 

# Inbound rule for HTTP 

ingress {
  description = "HTTP from anywhere"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress {
  description = "SSH from anywhere"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
egress {
  from_port = 0
  to_port = 0
  protocol = "-1" # -1 means all protocol
  cidr_blocks = ["0.0.0.0/0"]
}
tags = {
  Name = "Dev-Web-SG"

}
}

# Creating ec2 instance
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  
  subnet_id = aws_subnet.public_subnet.id
  
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # The Bash script that runs on first boot
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform! My custom VPC works!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Dev-Web-Server"
  }
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}