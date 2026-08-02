data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = ["amazon"]
    
    filter {
        name = "name"
        values = ["al2023-ami-*-x86_64"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }  
}


resource "aws_instance" "example" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    tags = {
        Name = "Learning-Instance"
    }
  
}