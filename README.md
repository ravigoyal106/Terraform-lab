# Terraform Lab

Hands-on Terraform practice, learning infrastructure as code by actually building
and running it, not just reading about it.

## What's Inside

### `terraform-local/`
Getting comfortable with Terraform core concepts on a local machine before touching
real cloud infrastructure. Practiced writing configs, understanding state, and running
the full `init → plan → apply → destroy` lifecycle using the local provider no AWS
account needed.

- Terraform basics - providers, resources, variables, outputs
- State file behavior and what `terraform.tfstate` actually does
- Plan vs apply - reading diffs before committing changes
- `destroy` workflow and resource lifecycle

### `terraform-aws/`
Moved to the AWS provider and provisioned real infrastructure. Focused on the
core building blocks you'll find in almost every production AWS environment.

- **EC2** - launched instances, configured AMI, instance type
- **S3** - created buckets, applied settings
- **VPC** - built networking layer with subnets and route tables

## Why This Repo Exists

I built this to develop real muscle memory with Terraform reading docs,
writing configs from scratch, breaking things, and fixing them. Every file
here was written and run, not copy-pasted.

## Tech Stack

`Terraform` · `AWS Provider` · `Local Provider` · `EC2` · `S3` · `VPC`