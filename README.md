# trilium

> Trilium server on AWS

[![Infrastructure check](https://github.com/cednore/trilium/actions/workflows/check.yml/badge.svg)](https://github.com/cednore/trilium/actions/workflows/check.yml)

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://terraform.io/)
[![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)](https://ansible.com/)
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com/)

## ✨ Introduction

This project demonstrates how-to of hosting [`zadam/trilium`](https://github.com/zadam/trilium) on your AWS
infrastructure. If you want to self-host your very own personal knowledge base on AWS, this project could be a good
starting point. You can easily use this project as a boilerplate for managing your trilium hosting infrastructure in IaC
way, automatic infrastructure provisioning, frequent drift-checking, and more. And also
([@cednore](https://github.com/cednore)) uses this repository to manage his own trilium hosting as well 😉.

Before you start, it is strongly recommended to read [trilium wiki](https://github.com/zadam/trilium/wiki) first,
especially [server installation/deployment page](https://github.com/zadam/trilium/wiki/Docker-server-installation).

### What's included 🗃️

1. A single terraform project defining hosting infrastructure and provisioners
2. Terragrunt wrapper, to variablize terraform backend and providers
3. Auto-generated [terraform documentation](#terraform-documentation)
4. [GitHub action](https://github.com/cednore/trilium/actions/workflows/check.yml) for infrastructure drift checking (on
   every push, scheduled)
5. Time-saving development scripts
6. Guides and documentations

### Infrastructure summary 🏗️

1. Single **VPC** with 3 public/private subnets
2. App instance by **EC2** (default `t3.micro`), publicly accessible via SSH
3. **Docker**ized app container (default count `1`)
4. Frontline **ALB** with HTTP/HTTPS listeners
5. **ACM** certificate attached to ALB (use apex domain's ACM by default, assuming this covers subdomains as well)
6. **EBS** data volume attached (default `20GB`)
7. **DLM lifecycle policy** to snapshot data volume (`every Sunday` by default, keeping last 4 snapshots)
8. **CloudWatch log group** to keep app container logs
9. **S3** bucket to keep ALB logs
10. **Security group**s for app instance and ALB
11. **Route53** records for domain name registration (default subdomain level)
12. **Ansible** playbooks to provision app container and data volume
13. Everything is written in **Terraform**, highly modularized

## 🧱 Prerequisites

1. [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli) `>= 1.2`
2. [Terragrunt CLI](https://terragrunt.gruntwork.io/docs/getting-started/install/) `>= 0.38.0`
3. An AWS account
4. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) (with credentials
   configured)
5. S3 backend (a S3 bucket a DynamoDB table)
6. A personal domain, Route 53 hosted zone, and an ACM certificate. (preferably for the apex domain, which is subject to
   all subdomains as well)
7. SSH keypair, for connecting app instance
8. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (for provisioning
   playbooks)
9. [terraform-docs](https://terraform-docs.io/user-guide/installation/)
10. Node.js + Yarn (for development scripts and utilities)
11. SQLite DB Browser (optional, for manually tweaking app db)
12. Basic utilities `ssh`, `scp`, `jq` (for development scripts)
13. Code editor/IDE ofc 😉

## ⚡ Getting started

```bash
# Clone from github
git clone git@github.com:cednore/trilium.git

# Cd into repo directory
cd trilium

# Install nodejs modules
yarn install

# Initialize project
yarn initialize

# Select stage
yarn stage production # or other stages

# Download keypair and tfvars file from backend bucket
yarn download:keypair
yarn download:tfvars

# Terragrunt plan
yarn plan
```

## 🔨 Development scripts

### Selecting stage

This project uses [terraform workspace](https://www.terraform.io/cli/workspaces) to manage different stages. Below
command is equivalent to `terraform workspace select production`.

> ⚠️ WARNING: Don't use `default` workspace.

```bash
# Select production stage
yarn stage production
```

### Outputs

Automation pipelines and many development script uses terraform output file. Use below command to generate output in
JSON format.

See [`outputs.tf`](outputs.tf) file and check out what's being outputted.

> ⚠️ WARNING: Sensitive data is also included in terraform output. Please hide/mask sensitive values from being displayed
> in public place where everyone is accessible (e.g CI/CD pipelines' stdout).

```bash
# Terraform output in json format
yarn output:json
```

### Generating terraform graph

Below command is used to generate a visual representation of terraform plan. The output is in DOT initially, and also
SVG format, which is converted by GraphViz.

```bash
# Generate terraform graph and convert into svg format (requires graphviz)
yarn graph
```

### Keypairs and tfvars

Keypair file and tfvars files are essential parts of this project. It uses \*.pem format keyfile for SSH connection into
EC2 app instance, tfavrs file for customized terraform variables. This project assumes these files are stored inside
backend bucket (S3), along with tfstate file.

If you are starting a new hosting based on this repository, you might wanna generate a new keypair for your EC2 app
instance.

```bash
# Download keypair from backend bucket
yarn download:keypair

# Download tfvars from backend bucket
yarn download:tfvars

# Generate a new keypair, if you don't have one already
yarn key:generate

# Upload keypair to backend bucket
yarn upload:keypair

# Upload tfvars to backend bucket
yarn upload:tfvars
```

### Formatting & linting & validation

```bash
# Format check tf files
yarn fmt:check

# Format tf files
yarn fmt

# Lint project (by tflint)
yarn lint

# Validate terraform project
yarn validate
```

### Interacting with live server

Often, you might wanna login to app instance (EC2) and run a few commands or download/upload app data.

> ℹ️ INFO: `restart:app` command is useful when facing
> [`broken branch/note` issue](https://github.com/zadam/trilium/issues/2950).

```bash
# Open a ssh session into app instance
yarn connect

# Restart app container (this fixes broken notes and branches)
yarn restart:app

# Download app db file (sqlite)
yarn download:db

# Upload app db file
yarn upload:db
```

### Terraform documentation

This project uses [**terraform-docs**](https://terraform-docs.io) to auto-generate markdown document of terraform
resources being used. You can run following command to run the generator.

```bash
yarn tf-docs
```

Generated document will be stored at [`docs/terraform.md`](docs/terraform.md).

## 👋 Contributions

Contributions are welcome by opening issues and pull requests. See [CONTRIBUTING.md](CONTRIBUTING.md) file for details.

## 🚧 Roadmap

- [ ] Seperate CloudWatch logs every single day
- [ ] Self-starter/forking guide
- [ ] Budget-tracking
- [ ] SRE concepts; monitoring performance and more
- [ ] Diagrams explaining the infrastructure
- [ ] GitHub issue templates; `bug`, `security`, `cost`, `feature` and so on

## 📄 License

This project is licensed under the MIT License.

## 🙇 Credits

- Credit to [@zadam](https://github.com/zadam) for building such a beautiful note-taking app. (and also powerful
  🐋 image and documentation)
- Special thanks to [@geneccx](https://github.com/geneccx) for giving me this whole idea.
- Thanks to [`gitmoji`](https://gitmoji.dev/), I use it everyday.
