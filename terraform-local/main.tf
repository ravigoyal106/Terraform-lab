# Terraform block --Setting terraform itself

terraform {
  required_providers {
    local = {
        source = "hashicorp/local"
        version = "~> 2.0"
    }
  }
}

# Provider block
provider "local" {}

# Resource Block
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

# Resorce using variable
resource "local_file" "var-testfile" {
  filename = "${path.module}/vartestfile.txt"
  content = var.file_content  # Ref. the variable above block
  lifecycle {
    prevent_destroy = true
  }
}

# Output
output "vartestfile_path" {
  value = local_file.var-testfile.filename
}
