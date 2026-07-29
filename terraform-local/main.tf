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
    content = "Hello, This is my first terraform resource"
}

# Terraform variables
variable "file_content" {
  description = "Content to write into the file"
  type = string
  default = "Variable Refrencing the content of the file" 
}

resource "local_file" "var-testfile" {
  filename = "${path.module}/vartestfile.txt"
  content = var.file_content  # Ref. the variable above block
}
