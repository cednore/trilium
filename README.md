[![License](https://img.shields.io/github/license/cednore/trilium)](LICENSE)
![Language count](https://img.shields.io/github/languages/count/cednore/trilium)
![Top language](https://img.shields.io/github/languages/top/cednore/trilium)
[![Contributors](https://img.shields.io/github/contributors/cednore/trilium)](https://github.com/cednore/trilium/graphs/contributors)
[![Stargazers](https://img.shields.io/github/stars/cednore/trilium?style=social)](https://github.com/cednore/trilium/stargazers)
[![Forks](https://img.shields.io/github/forks/cednore/trilium?style=social)](https://github.com/cednore/trilium/network/members)

# trilium

> Trilium server on AWS

[![Infrastructure](https://github.com/cednore/trilium/actions/workflows/infrastructure.yml/badge.svg)](https://github.com/cednore/trilium/actions/workflows/infrastructure.yml)
[![Security](https://github.com/cednore/trilium/actions/workflows/security.yml/badge.svg)](https://github.com/cednore/trilium/actions/workflows/security.yml)
[![Lint](https://github.com/cednore/trilium/actions/workflows/lint.yml/badge.svg)](https://github.com/cednore/trilium/actions/workflows/lint.yml)
[![Current online status](https://img.shields.io/website?down_color=lightgrey&down_message=offline&label=notes.cednore.me&up_color=blue&up_message=online&url=https%3A%2F%2Fnotes.cednore.me)](https://notes.cednore.me)

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com/)
[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://terraform.io/)
[![Terragrunt](https://img.shields.io/badge/Terragrunt-2274EA?style=for-the-badge&logo=data:image/png;base64,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)](https://terragrunt.gruntwork.io/)
[![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)](https://ansible.com/)

## ✨ Introduction

This project demonstrates how-to of hosting [trilium](https://github.com/zadam/trilium) on your AWS infrastructure. If
you want to self-host your very own personal knowledge base on AWS, this project could be a good starting point. You can
easily use this project as a boilerplate for managing your trilium hosting infrastructure in IaC way; automatic
infrastructure provisioning, frequent drift-checking, security scanning and more. (I use this repository too for
managing my own trilium hosting 😉.)

Before you start, it is strongly recommended to read [trilium wiki](https://github.com/zadam/trilium/wiki) first,
especially [server installation/deployment page](https://github.com/zadam/trilium/wiki/Docker-server-installation).

### What's included 🗃️

1. A **terragrunt** project defining multi-staged hosting infrastructure and provisioners
2. Auto-generated [terraform documentation](#terraform-documentation)
3. GitHub actions;
   - Infrastructure drift detection (on every push, scheduled)
   - Linting and formatting (`terraform fmt`, `terragrunt hclfmt`, `tflint`)
   - Security vulnerability scanning (`checkov`, `tfsec`)
4. Time-saving development scripts by [justfile](https://github.com/casey/just)
5. Documentations, including self-start/forking guide

### Infrastructure summary 🏗️

1. Single **VPC** with `3` public/private subnets
2. An **EC2** instance (`t3.micro` as default), publicly accessible via SSH
3. **Docker**ized app container (default `zadam/trilium:0.55.1`)
4. HTTPS proxy powered by **nginx** (inside a docker container)
5. **CloudWatch log group** to keep app logs and proxy logs
6. **S3** bucket to keep the app data backups
7. **Security group**s for the app instance
8. **Route53** records for domain name registration (subdomain level as default)
9. A SSL certificate issued by **Let's Encrypt** for the app domain name
10. **Ansible** playbooks to install and configure trilium on the EC2 instance
11. Everything is written in **Terraform**, highly modularized, wrapped by **Terragrunt**

## 🧱 Prerequisites

### Cloud

1. An AWS account + [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
   (with credentials configured)
2. S3 backend (a S3 bucket and a DynamoDB table)
3. A personal domain and a public Route53 hosted zone managing this personal domain
4. A SSH keypair `.keypair.pem`, along with terraform state file inside the backend bucket, and an ASM secret for
   holding secrets and configurations (these will be read and downloaded while applying, see `generate "secrets"` block
   at [`terragrunt.hcl`](terragrunt.hcl))
5. `.env` file, for environment variables (see [`.env.example`](.env.example))

### Development tools

1. [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) `>= 1.3` +
   [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) `>= 0.38`
2. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html), for provisioning
   playbooks
3. [just](https://github.com/casey/just), for running development scripts
4. [TFLint](https://github.com/terraform-linters/tflint), for linting tf files
5. [terraform-docs](https://terraform-docs.io/user-guide/installation/), for generating terraform documentation
   (optional)
6. [tfsec](https://github.com/aquasecurity/tfsec) and [Checkov](https://www.checkov.io/), for scanning security
   vulnerabilities (optional)
7. SQLite DB Browser (optional, for manually tweaking app db)
8. Code editor/IDE ofc 😉

## ⚡ Getting started

### 1. Clone this repository

```bash
# clone from github
git clone git@github.com:cednore/trilium.git

# cd into repo directory
cd trilium
```

### 2. Configure project

Before start, prepare dotenv file at `.env`. If you don't have `.env` file, you can create a new one by
`cp .env.example .env` and customize with your own settings.

### 3. Intialize project

```bash
just init
```

### 4. Try create an execution plan

```bash
just tg plan
```

## 🔨 Development scripts

[just](https://github.com/casey/just) is being used to define and run development scripts. You can simply run
`just --list` or see [`justfile`](justfile) to check out all of available development scripts.

```
$ just --list
Available recipes:
    check-output         # check if output.json file exists
    connect *args=''     # open a ssh session into app instance
    dbdump               # download app db file (sqlite)
    dbrestore            # upload app db file
    default              # list available recipes
    drift-check *args='' # check for infrastructure drift
    fmt                  # format tf and hcl files
    graph                # generate terraform graph and convert into svg format (requires graphviz)
    init *args=''        # initialize terragrunt project
    lint                 # lint project (by tflint)
    output-json          # terragrunt output in json format (into output.json)
    restart              # restart app container (this fixes broken notes and branches)
    tfdocs               # generate terraform documentation in markdown
    tg *args=''          # wrap terragrunt with dotenv loading
    trilium-install      # run trilium installer playbook from local
    upgrade *args=''     # upgrade providers
    validate *args=''    # validate terragrunt project
```

### Basic terragrunt scripts

Terragrunt doesn't load dotenv file automatically (see https://github.com/gruntwork-io/terragrunt/issues/1750), so I've
wrapped all terragrunt commands with preloading of dotenv files (see [`justfile`](justfile)). Replace `terragrunt` with
`just tg` to run your terragrunt commands with environment variables set from `.env` file.

```bash
# initialize terragrunt project
just init

# upgrade providers
just upgrade

# validate terragrunt project
just validate

# equivalent of `terragrunt plan` with dotenv loading
just tg plan

# equivalent of `terragrunt apply` with dotenv loading
just tg apply

# check for infrastructure drift
just drift-check
```

> ℹ️ INFO: Environment variables inside `.env` file is mandatory for terragrunt to run. Terragrunt will go fail without
> them. If you are going to run terragrunt commands without `just`, You should use dotenv cli tools like
> [dotenv-cli](https://github.com/entropitor/dotenv-cli) or [python-dotenv](https://github.com/theskumar/python-dotenv).

### Outputs

Automation pipelines and many development script uses terraform output file. Use below command to generate output in
JSON format.

See [`outputs.tf`](outputs.tf) file and check out what's being outputted.

> ⚠️ WARNING: The terraform output includes sensitive data. Please hide/mask sensitive values from being displayed in
> public place where everyone is accessible (e.g CI/CD pipelines' stdout and stderr).

```bash
# terragrunt output in json format (into output.json)
just output-json
```

> ℹ️ INFO: `output.json` file is gitignored.

### Generating terraform graph

Below command is used to generate a visual representation of terraform plan. The output is in DOT initially, and also
SVG format, which is converted by GraphViz.

```bash
# generate terraform graph and convert into svg format (requires graphviz)
just graph
```

### Formatting & linting

```bash
# format tf and hcl files
just fmt

# lint project (by tflint)
just lint
```

### Terraform documentation

This project uses [**terraform-docs**](https://terraform-docs.io) to auto-generate markdown document of terraform
resources being used. You can run following command to run the generator.

```bash
# generate terraform documentation in markdown
just tfdocs
```

Generated document will be stored at [`docs/terraform.md`](docs/terraform.md).

### Interacting with live server

Often, you might wanna login to app instance (EC2) and run a few commands or download/upload app data.

> ⚠️ WARNING: Below commands depends on terragrunt output file `output.json`. You can run `just output` to generate this
> file.

```bash
# run trilium installer playbook from local
just trilium-install

# open a ssh session into the app instance
just connect

# run a command remotely on the app instance
just connect free -hw

# restart app container
just restart

# download app db file (sqlite)
just dbdump

# upload app db file
just dbrestore
```

> ℹ️ INFO: `just restart` command is useful when facing
> [_broken branch_ issue](https://github.com/zadam/trilium/issues/2950).

## 👋 Contributions

Contributions are welcome by opening issues and pull requests. See [CONTRIBUTING.md](CONTRIBUTING.md) file for details.

## 🚧 Roadmap

- [ ] Automagical backup to S3 bucket
- [ ] dbdump not working due to permission error
- [ ] Self-starter/forking guide
- [ ] Budget-tracking
- [ ] SRE concepts; monitoring performance and more
- [ ] Diagrams explaining the infrastructure
- [ ] GitHub issue templates; `bug`, `security`, `cost`, `feature` and so on
- [ ] GitHub PR template

## 📄 License

This project is licensed under the **MIT License**.

## 🙇 Credits

- Credit to [@zadam](https://github.com/zadam) for building such a beautiful note-taking app. (and also powerful
  🐋 image and documentation)
- Special thanks to [@geneccx](https://github.com/geneccx) for giving me this whole idea.
- Thanks to [`gitmoji`](https://gitmoji.dev/), I use it everyday.
