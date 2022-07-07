tflint-init:
	tflint --init

init: tflint-init
	dotenv run terragrunt init $(ARGS)

plan:
	dotenv run terragrunt plan $(ARGS)

validate:
	dotenv run terragrunt validate $(ARGS)

apply:
	dotenv run terragrunt apply $(ARGS)

output:
	dotenv run terragrunt output -json > output.json

graph:
	dotenv run terragrunt graph -draw-cycles > graph.gv && dot -Tsvg graph.gv > graph.svg

keygen:
	ssh-keygen -t rsa -m PEM -f .keypair.pem -N '' -C '' && chmod 400 .keypair.pem

fmt:
	terraform fmt -recursive $(ARGS)

fmt-check:
	make fmt -check -diff $(ARGS)

lint:
	tflint $(ARGS)

lint-ci:
	make lint -f compact $(ARGS)

connect:
	ssh -i .keypair.pem $(jq -r '.app_instance_username.value' output.json)@$(jq -r '.app_instance_public_ip.value' output.json)

restart:
	make connect sudo docker restart $(jq -r '.app_container_name_prefix.value' output.json)1

dbdump:
	scp -i .keypair.pem $(jq -r '.app_instance_username.value' output.json)@$(jq -r '.app_instance_public_ip.value' output.json):$(jq -r '.data_volume_mount_path.value' output.json)/document.db .

dbrestore:
	scp -i .keypair.pem document.db $(jq -r '.app_instance_username.value' output.json)@$(jq -r '.app_instance_public_ip.value' output.json):$(jq -r '.data_volume_mount_path.value' output.json)/document.db

tfdocs:
	terraform-docs . -c .terraform-docs.yml
