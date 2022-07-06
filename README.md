# trilium

> My personal trilium server on cloud

[![Infrastructure check](https://github.com/cednore/trilium/actions/workflows/check.yml/badge.svg)](https://github.com/cednore/trilium/actions/workflows/check.yml)

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://terraform.io/)
[![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)](https://ansible.com/)
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com/)

## Getting started

```bash
# Clone from github
git clone git@github.com:cednore/trilium.git

# Cd into repo directory
cd trilium

# Install nodejs modules
yarn install

# Initialize terraform project
terraform init

# Select stage
yarn stage production # or other stages

# Download private key and tfvars file
yarn download:private-key
yarn download:tfvars
```

## Linting & validation

```bash
# Lint tf files
yarn lint

# Lint tf files and fix
yarn lint:fix

# Validate terraform project
terraform validate
```

## Interacting with live server

```bash
# Open a ssh session into app instance
yarn connect

# Download app db file (sqlite)
yarn download:db

# Upload app db file
yarn upload:db

# Restart app container
yarn restart:app
```

## Terraform documentation

This project uses [**terraform-docs**](https://terraform-docs.io) to auto-generate markdown document of terraform
resources being used. You can run following command to run the generator.

```bash
yarn tf-docs
```

Generated document will be stored at [`docs/terraform.md`](docs/terraform.md).
