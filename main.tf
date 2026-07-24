terraform {
  required_providers {
    local = {
        source = "hashicorp/local"
        version = "~> 2.0"
    }
  }
}

provider "local" {}

resource "local_file" "Hello" {
    filename = "${path.module}/Hello.txt"
    content = "Hello, This is my terraform first file UPDATE"
  
}

resource "local_file" "summury" {
  filename = "${path.module}/summury.txt"
  content = "This summury references: ${local_file.Hello.filename}"
}