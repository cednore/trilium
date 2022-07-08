# trilium

> Trilium server on AWS

[![Infrastructure check](https://github.com/cednore/trilium/actions/workflows/check.yml/badge.svg)](https://github.com/cednore/trilium/actions/workflows/check.yml)

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com/)
[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://terraform.io/)
[![Terragrunt](https://img.shields.io/badge/Terragrunt-2274EA?style=for-the-badge&logo=data:image/png;base64,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)](https://terragrunt.gruntwork.io/)
[![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)](https://ansible.com/)

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
3. An AWS account
4. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) (with credentials
   configured)
5. S3 backend (a S3 bucket and a DynamoDB table)
6. A personal domain, Route 53 hosted zone, and an ACM certificate (preferably for the apex domain, which is subject to
   all subdomains as well).
7. SSH keypair at `.keypair.pem`, for connecting app instance
8. `.env` file, for environment variables (see [`.env.example`](.env.example))
9. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (for provisioning
   playbooks)
10. [terraform-docs](https://terraform-docs.io/user-guide/installation/)
11. [TFLint](https://github.com/terraform-linters/tflint)
12. SQLite DB Browser (optional, for manually tweaking app db)
13. Basic utilities `ssh`, `scp`, `jq` (for development scripts)
14. Code editor/IDE ofc 😉

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
   customize with your own settings.
2. Prepare keypair file at `.keypair.pem`. You should either download from your secret vault or generate one by
   `make keygen` if you don't have already.

> ⚠️ WARNING: Don't wrap environment variables in double quote inside the `.env` file.

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
wrapped basic terragrunt commands with preloading of dotenv files (see [`Makefile`](Makefile)).

```bash
# terragrunt init
make init # this initializes tflint as well

# terragrunt plan
make plan

# terragrunt validate
make validate

# terragrunt apply
make apply
```

For the rest of the terragrunt commands, you need to load the dotenv file prior to actual run, otherwise it fails. You
can use dotenv cli tools like [`dotenv-cli`](https://github.com/entropitor/dotenv-cli) or
[`python-dotenv`](https://github.com/theskumar/python-dotenv).

> ⚠️ WARNING: Don't wrap environment variables in double quote inside the `.env` file.

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
# Format tf files
make fmt

# Lint project (by tflint)
make lint
```

### Terraform documentation

This project uses [**terraform-docs**](https://terraform-docs.io) to auto-generate markdown document of terraform
resources being used. You can run following command to run the generator.

```bash
make tfdocs
```

Generated document will be stored at [`docs/terraform.md`](docs/terraform.md).

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

> ℹ️ INFO: `make restart` command is useful when facing
> [`broken branch/note` issue](https://github.com/zadam/trilium/issues/2950).

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
