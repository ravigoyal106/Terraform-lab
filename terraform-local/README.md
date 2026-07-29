### This Repo is for leaning Terraform concepts.
### All Labs performed on Local Machine (terraform provider local)

- `terraform init` Downloads the providers/plugins we need
- `terraform plan` Shows what will be created/chnage/destroyed
- `terraform apply` Execute the plan what we want to create/chnage
- `terraform destroy` Destroy what we created 

## Providers

A provider is a plugin that lets Terraform talk to a specific platform (AWS, Azure, GCP, Kubernetes, etc.). It translates your Terraform code into actual API calls to that platform.
```
provider "aws" {
  region = "us-east-1"
}
```
---
### `terraform.tfstate` file
This is Terraform's memory. It records what infrastructure it has already created and maps it to our code.
`terraform.tfstate` often conatins sensitive data.

## Resources, Variables, and Outputs

## 1. Resource - The actual infra
- A resource block tell terraform create this resource.
```
resource "aws_instance" "my_server" {
  ami           = "ami-0123456789"
  instance_type = "t2.micro"
}

# resource --Keyword always start a resouce block
# aws_instance -- the resource type defined by provider.
# my_server -- Local name(not the real aws name)
# inside {} argument for that resource like here "t2.micro"
```

## 2. Variables
```
variable "instance_type" {
  description = ""
  type = string
  default = "t2.micro"
}

# use this variable
resource "aws_instance" "my_server" {
  ami           = "ami-0123456789"
  instance_type = var.instance_type # Ref variable
}
```
## 3. Output Block
```
output "hello_file_path" {
  value       = local_file.Hello.filename
  description = "Path of the created file"
  sensitive   = false
}
# value — required the actual data to expose
# description — optional, self-documenting
# sensitive — hides value from CLI output 
```