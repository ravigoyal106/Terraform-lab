### This Repo is for leaning Terraform concepts.
### All Labs performed on Local Machine

- `terraform init` Downloads the providers/plugins we need
- `terraform plan` Shows what will be created/chnage/destroyed
- `terraform apply` Execute the plan what we want to create/chnage
- `terraform destroy` Destroy what we created 

### Providers

A provider is a plugin that lets Terraform talk to a specific platform (AWS, Azure, GCP, Kubernetes, etc.). It translates your Terraform code into actual API calls to that platform.
```
provider "aws" {
  region = "us-east-1"
}
```