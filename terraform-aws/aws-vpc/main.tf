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