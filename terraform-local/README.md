# Terraform Basics

This repo is for learning core Terraform concepts. All labs are performed on a local machine using the `local` provider.

## Core Commands

- `terraform init` Downloads the providers/plugins needed for the code 
- `terraform plan` Shows what will be created, changed, or destroyed
- `terraform apply`  Executes the plan and actually creates/changes the infrastructure 
- `terraform destroy`  Tears down everything Terraform created

---

## Providers

A provider is a plugin that lets Terraform talk to a specific platform (AWS, Azure, GCP, Kubernetes, etc.). It translates your Terraform code into real API calls against that platform.

```
provider "aws" {
  region = "us-east-1"
}
```

---

### The `terraform.tfstate` File

- This is Terraform's memory. It records what infrastructure has already been created and maps it back to your code. `terraform.tfstate` often contains sensitive data.
---

## Resources, Variables, and Outputs

### 1. Resource — the actual infrastructure

A `resource` block tells Terraform to create something.

```
resource "aws_instance" "my_server" {
  ami           = "ami-0123456789"
  instance_type = "t2.micro"
}
```

- `resource` — keyword that always starts a resource block
- `aws_instance` — the resource type, defined by the provider
- `my_server` — the local name (not the real AWS name)
- everything inside `{}` — the arguments for that resource, e.g. `"t2.micro"`

### 2. Variables

Variables let you avoid hardcoding values, so the same code can be reused with different inputs.

```
variable "instance_type" {
  description = "EC2 instance type to use"
  type        = string
  default     = "t2.micro"
}

# Using the variable
resource "aws_instance" "my_server" {
  ami           = "ami-0123456789"
  instance_type = var.instance_type # Reference to the variable
}
```

### 3. Outputs

Outputs expose values from your infrastructure after it's created — useful for debugging or chaining into other configs.

```
output "hello_file_path" {
  value       = local_file.Hello.filename
  description = "Path of the created file"
  sensitive   = false
}
```

- `value` — required, the actual data to expose
- `description` — optional, self-documenting
- `sensitive` — hides the value from CLI output

---

## `count` and `for_each`

`count` lets you create multiple copies of the same resource from a single block.

```
resource "local_file" "countuses" {
  filename = "${path.module}/countuses-${count.index}.txt"
  content  = "This is file number ${count.index}"
  count    = 3
}
```

- `count = 3` creates 3 instances of this resource
- `count.index` gives `0`, `1`, `2` for each instance
- Result: `countuses-0.txt`, `countuses-1.txt`, `countuses-2.txt`

### `for_each`
