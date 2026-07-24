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