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
}

# Output
 output "vartestfile_path" {
  value = local_file.var-testfile.filename
}


# count tells tf create 3 instances of this resource

resource "local_file" "countuses" {
  filename = "${path.module}/countuses-${count.index}.txt" 
  content = "This is file number  ${count.index}"
  count = 3
}

# `foreach` 

resource "local_file" "foreach_test" {
  for_each = toset(["dev", "prod"])
  filename = "${path.module}/${each.key}.txt"
  content =  "This is the ${each.value} environment file" 
  # will create files dev.txt,staging.txt and prod.txt
}







