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
	ssh -i .keypair.pem $(jq -r '.app_instance_username.value' output.json)@$(jq -r '.app_instance_public_ip.value' output.json) "$@"

# restart app container (this fixes broken notes and branches)
restart: check-output
	just connect sudo docker restart $(jq -r '.app_container_name_prefix.value' output.json)1

# download app db file (sqlite)
dbdump: check-output
	scp -i .keypair.pem $(jq -r '.app_instance_username.value' output.json)@$(jq -r '.app_instance_public_ip.value' output.json):$(jq -r '.data_volume_mount_path.value' output.json)/document.db .

# upload app db file
dbrestore: check-output
	scp -i .keypair.pem document.db $(jq -r '.app_instance_username.value' output.json)@$(jq -r '.app_instance_public_ip.value' output.json):$(jq -r '.data_volume_mount_path.value' output.json)/document.db
