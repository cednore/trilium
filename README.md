# trilium

> Trilium server on AWS

[![Infrastructure check](https://github.com/cednore/trilium/actions/workflows/check.yml/badge.svg)](https://github.com/cednore/trilium/actions/workflows/check.yml)

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://terraform.io/)
[![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)](https://ansible.com/)
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com/)

## Introduction

This project demonstrates how-to of hosting [`zadam/trilium`](https://github.com/zadam/trilium) on your AWS
infrastructure. If you want to host your very own personal knowledge base on AWS, this project could be a good starting
point. You can easily use this project as a boilerplate for managing your trilium hosting infrastructure in IaC way,
automatic infrastructure provisioning, frequent drift-checking, and more. And also
([@cednore](https://github.com/cednore)) uses this repository to manage his own trilium hosting as well 😉.

Before you start, it is strongly recommended to read [trilium wiki](https://github.com/zadam/trilium/wiki) first,
especially [server installation/deployment page](https://github.com/zadam/trilium/wiki/Docker-server-installation).

### What's included

1. A single terraform project defining hosting infrastructure and provisioners
2. Auto-generated [terraform documentation](#terraform-documentation)
3. [GitHub action](https://github.com/cednore/trilium/actions/workflows/check.yml) for infrastructure drift checking (on
   every push, scheduled)
4. Time-saving development scripts
5. Guides and documentations

### Infrastructure summary

1. Single **VPC** with 3 public/private subnets
2. App instance on **EC2** (default `t3.micro`), publicly accessible via SSH
3. **Docker**ized app container (default count `1`)
4. Frontline **ALB** with HTTP/HTTPS listeners
5. **ACM** certificate attached to ALB (use apex domain's ACM by default, assuming this covers subdomains as well)
6. **EBS** data volume attached (default 20GB)
7. **CloudWatch event rule** to backup data volume (every Sunday by default)
8. **CloudWatch log group** to keep app container logs
9. **S3** bucket to keep ALB logs
10. **Security group**s for app instance and ALB
11. **Route53** records for domain name registration (default subdomain level)
12. **Ansible** playbooks to provision app container and data volume
13. Everything is written in **Terraform**, highly modulized

## Prerequisites

1. [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli) `>= 1.2`
2. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) (with credentials
   configured)
3. S3 backend (a S3 bucket for state and a DynamoDB table for lock)
4. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (for provisioning
   playbooks)
5. [terraform-docs](https://terraform-docs.io/user-guide/installation/)
6. Node.js + Yarn (for development scripts and utilities)
7. SQLite DB Browser (optional, for manually tweaking app db)
8. Basic utilities `ssh`, `scp`, `jq` (for development scripts)
9. Code editor/IDE ofc 😉

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

## Development scripts

### Linting & validation

```bash
# Lint tf files
yarn lint

# Lint tf files and fix
yarn lint:fix

# Validate terraform project
terraform validate
```

### Interacting with live server

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

### Terraform documentation

This project uses [**terraform-docs**](https://terraform-docs.io) to auto-generate markdown document of terraform
resources being used. You can run following command to run the generator.

```bash
yarn tf-docs
```

Generated document will be stored at [`docs/terraform.md`](docs/terraform.md).

## Contributions

Contributions are welcome by opening issues and pull requests. See [CONTRIBUTING.md](CONTRIBUTING.md) file for details.

## Roadmap

- [ ] Automatic deletion of old data volume snapshots (🤔 really?)
- [ ] Seperate CloudWatch logs every single day
- [ ] Self-starter guide
- [ ] Budget-tracking
- [ ] SRE concepts; monitoring performance and more
- [ ] Diagrams explaining the infrastructure
- [ ] GitHub issue templates; `bug`, `security`, `cost`, `feature` and so on

## License

This project is licensed under the MIT License.

## Credits

- Credit to [@zadam](https://github.com/zadam) for building such a beautiful note-taking app. (and also powerful
  🐋 image and documentation)
- Special thanks to [@geneccx](https://github.com/geneccx) for giving me this whole idea.
- Thanks to [`gitmoji`](https://gitmoji.dev/), I use it everyday.
