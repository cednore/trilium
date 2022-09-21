set dotenv-load
set positional-arguments

# list available recipes
default:
  just --list

# wrap terragrunt with dotenv loading
@tg *args='':
  terragrunt "$@"

# initialize terragrunt and tflint
init:
  tflint --init
  terragrunt init

# terragrunt output in json format (into output.json)
output:
	terragrunt output -json > output.json

# generate terraform graph and convert into svg format (requires graphviz)
graph:
	terragrunt graph -draw-cycles > graph.gv && dot -Tsvg graph.gv > graph.svg

# generate a new keypair
keygen:
	ssh-keygen -t rsa -m PEM -f .keypair.pem -N '' -C '' && chmod 400 .keypair.pem

# format tf files
fmt:
	terraform fmt -recursive

# format hcl files
hclfmt:
	terragrunt hclfmt

# lint project (by tflint)
lint:
	tflint

# generate terraform documentation in markdown
tfdocs:
	terraform-docs . -c .terraform-docs.yml

# check if output.json file exists
check-output:
	test -f output.json

# open a ssh session into app instance
@connect *args='': check-output
	eval $(jq -r '.cmd_ssh_to_app_instance.value' output.json) "$@"

# restart app container (this fixes broken notes and branches)
restart: check-output
	eval $(jq -r '.cmd_restart_app_container.value' output.json)

# download app db file (sqlite)
dbdump: check-output
	eval $(jq -r '.cmd_download_app_db.value' output.json)

# upload app db file
dbrestore: check-output
	eval $(jq -r '.cmd_upload_app_db.value' output.json)
