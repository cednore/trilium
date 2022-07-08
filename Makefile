# Load dotenv file
ifneq (,$(wildcard ./.env))
  include .env
  export
endif

tflint-init:
	tflint --init

init: tflint-init
	terragrunt init

plan:
	terragrunt plan

validate:
	terragrunt validate

apply:
	terragrunt apply

output:
	terragrunt output -json > output.json

graph:
	terragrunt graph -draw-cycles > graph.gv && dot -Tsvg graph.gv > graph.svg

keygen:
	ssh-keygen -t rsa -m PEM -f .keypair.pem -N '' -C '' && chmod 400 .keypair.pem

fmt:
	terraform fmt -recursive

hclfmt:
	terragrunt hclfmt

lint:
	tflint

tfdocs:
	terraform-docs . -c .terraform-docs.yml

connect:
	ssh -i .keypair.pem $(shell jq -r '.app_instance_username.value' output.json)@$(shell jq -r '.app_instance_public_ip.value' output.json)

restart:
	make connect sudo docker restart $(shell jq -r '.app_container_name_prefix.value' output.json)1

dbdump:
	scp -i .keypair.pem $(shell jq -r '.app_instance_username.value' output.json)@$(shell jq -r '.app_instance_public_ip.value' output.json):$(shell jq -r '.data_volume_mount_path.value' output.json)/document.db .

dbrestore:
	scp -i .keypair.pem document.db $(shell jq -r '.app_instance_username.value' output.json)@$(shell jq -r '.app_instance_public_ip.value' output.json):$(shell jq -r '.data_volume_mount_path.value' output.json)/document.db
