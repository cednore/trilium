# Load dotenv file
ifneq (,$(wildcard ./.env))
  include .env
  export
endif

# Initialize TFLint
tflint-init:
	tflint --init

# Initialize terragrunt along with TFLint
init: tflint-init
	terragrunt init

# Create an execution plan
plan:
	terragrunt plan

# Validate project
validate:
	terragrunt validate

# Apply changes to infrastructure
apply:
	terragrunt apply

# Terragrunt output in json format (into output.json)
output:
	terragrunt output -json > output.json

# Generate terraform graph and convert into svg format (requires graphviz)
graph:
	terragrunt graph -draw-cycles > graph.gv && dot -Tsvg graph.gv > graph.svg

# Generate a new keypair
keygen:
	ssh-keygen -t rsa -m PEM -f .keypair.pem -N '' -C '' && chmod 400 .keypair.pem

# Format tf files
fmt:
	terraform fmt -recursive

# Format hcl files
hclfmt:
	terragrunt hclfmt

# Lint project (by tflint)
lint:
	tflint

# Generate terraform documentation in markdown
tfdocs:
	terraform-docs . -c .terraform-docs.yml

# Check if output.json file exists
check-output:
	test -f output.json

# Open a ssh session into app instance
connect: check-output
	ssh -i .keypair.pem $(shell jq -r '.app_instance_username.value' output.json)@$(shell jq -r '.app_instance_public_ip.value' output.json)

# Restart app container (this fixes broken notes and branches)
restart: check-output
	make connect sudo docker restart $(shell jq -r '.app_container_name_prefix.value' output.json)1

# Download app db file (sqlite)
dbdump: check-output
	scp -i .keypair.pem $(shell jq -r '.app_instance_username.value' output.json)@$(shell jq -r '.app_instance_public_ip.value' output.json):$(shell jq -r '.data_volume_mount_path.value' output.json)/document.db .

# Upload app db file
dbrestore: check-output
	scp -i .keypair.pem document.db $(shell jq -r '.app_instance_username.value' output.json)@$(shell jq -r '.app_instance_public_ip.value' output.json):$(shell jq -r '.data_volume_mount_path.value' output.json)/document.db
