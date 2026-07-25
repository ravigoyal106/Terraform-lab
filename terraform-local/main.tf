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
variable "file_content" {
  description = "Content to write into the file"
  type = string
  default = "Hello, This is my terraform first variable test"
}

resource "local_file" "File1" {
  filename = "${path.module}/File1.txt"
  content = var.file_content
  
}
output "File1_file_path" {
value = local_file.File1.filename  
}

# Terraform count and for_each

resource "local_file" "multi" {
  count = 3
  filename = "${path.module}/file-${count.index}.txt"
  content = "This is file number ${count.index}"
}

# for_each
resource "local_file" "multi_each" {
for_each = toset([ "dev", "staging", "prod" ])
filename = "${path.module}/${each.key}.txt"
content = "This is the file ${each.value} environment file"  
}
