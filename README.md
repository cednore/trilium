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

1. A terragrunt project defining hosting infrastructure and provisioners
2. Auto-generated [terraform documentation](#terraform-documentation)
3. [GitHub action](https://github.com/cednore/trilium/actions/workflows/check.yml) for infrastructure drift checking (on
   every push, scheduled)
4. Time-saving development scripts
5. Documentations, including self-start/forking guide

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

1. [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) `>= 1.2`
2. [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) `>= 0.38.0`
3. [dotenv-cli](https://github.com/entropitor/dotenv-cli)
4. An AWS account
5. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) (with credentials
   configured)
6. S3 backend (a S3 bucket and a DynamoDB table)
7. A personal domain, Route 53 hosted zone, and an ACM certificate (preferably for the apex domain, which is subject to
   all subdomains as well).
8. SSH keypair at `.keypair.pem`, for connecting app instance
9. `.env` file, for environment variables (see [`.env.example`](.env.example))
10. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (for provisioning
    playbooks)
11. [terraform-docs](https://terraform-docs.io/user-guide/installation/)
12. [TFLint](https://github.com/terraform-linters/tflint)
13. SQLite DB Browser (optional, for manually tweaking app db)
14. Basic utilities `ssh`, `scp`, `jq` (for development scripts)
15. Code editor/IDE ofc 😉

## ⚡ Getting started

### 1. Clone this repository

```bash
# Clone from github
git clone git@github.com:cednore/trilium.git

# Cd into repo directory
cd trilium
```

### 2. Configure project

1. Prepare dotenv file at `.env`. If you don't have `.env` file, you can create a new one by `cp .env.example .env` and
   customize with your own settings
2. Prepare keypair file at `.keypair.pem`. You should either download from your secret vault or generate one by
   `make keygen` if you don't have already.

### 3. Intialize project

```bash
make init
```

### 4. Try create an execution plan

```bash
make plan
```

## 🔨 Development scripts

### Basic terragrunt scripts

Terragrunt doesn't load dotenv file automatically (see https://github.com/gruntwork-io/terragrunt/issues/1750), so I've
wrapped basic terragrunt commands with [`dotenv-cli`](https://github.com/entropitor/dotenv-cli).

```bash
# terragrunt init
make init

# terragrunt plan
make plan

# terragrunt validate
make validate

# terragrunt apply
make apply
```

For the rest of the terragrunt commands, just append `dotenv run` in front of them to load the dotenv file and prior to
run. (e.g `dotenv run terragrunt destroy`)

### Outputs

Automation pipelines and many development script uses terraform output file. Use below command to generate output in
JSON format.

See [`outputs.tf`](outputs.tf) file and check out what's being outputted.

> ⚠️ WARNING: Sensitive data is also included in terraform output. Please hide/mask sensitive values from being displayed
> in public place where everyone is accessible (e.g CI/CD pipelines' stdout).

```bash
# Terraform output in json format (into output.json)
make output
```

> ℹ️ INFO: `output.json` file is gitignored.

### Generating terraform graph

Below command is used to generate a visual representation of terraform plan. The output is in DOT initially, and also
SVG format, which is converted by GraphViz.

```bash
# Generate terraform graph and convert into svg format (requires graphviz)
make graph
```

### Keypair and variable files

Keypair and dotenv file are essential parts of this project. It uses \*.pem format keypair file for SSH connection into
EC2 app instance, `.env` file for customized terragrunt variables.

If you are forking this repository and starting a new hosting, you might wanna generate a new keypair for your EC2 app
instance.

```bash
# Generate a new keypair, if you don't have one already
make keygen
```

> ℹ️ INFO: Keypair file is only needed when `terragrunt apply`. It's not necessary for `terragrunt plan`.

### Formatting & linting

```bash
# Format check tf files
make fmt-check

# Format tf files
make fmt

# Lint project (by tflint)
make lint
```

### Interacting with live server

Often, you might wanna login to app instance (EC2) and run a few commands or download/upload app data.

> ⚠️ WARNING: Below commands depends on terragrunt output file. Make sure you have `output.json` file. You can
> run `make output` to generate this file.

```bash
# Open a ssh session into app instance
make connect

# Restart app container (this fixes broken notes and branches)
make restart

# Download app db file (sqlite)
make dbdump

# Upload app db file
make dbrestore
```

> ℹ️ INFO: `restart:app` command is useful when facing
> [`broken branch/note` issue](https://github.com/zadam/trilium/issues/2950).

### Terraform documentation

This project uses [**terraform-docs**](https://terraform-docs.io) to auto-generate markdown document of terraform
resources being used. You can run following command to run the generator.

```bash
make tfdocs
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
