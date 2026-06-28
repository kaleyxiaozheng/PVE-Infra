.PHONY: init plan apply-template apply-nodes destroy-nodes clean

help:
	@echo "  make init           - Initialise Terraform"
	@echo "  make plan           - Show Terraform plan"
	@echo "  make apply-template - Create Ubuntu template"
	@echo "  make apply-nodes    - Deploy K3s nodes (automatically depends on template)"
	@echo "  make destroy-nodes  - Destroy K3s nodes (keep template)"
	@echo "  make clean          - Clean local Terraform cache"

init:
	terraform init

plan:
	terraform plan	

# 1. Deploy template: explicitly specify the target
apply-template:
	terraform apply -target=proxmox_virtual_machine.ubuntu_template -auto-approve

# 2. Deploy nodes: will automatically check the template, if the template does not exist it will error, so the order is important
# Here we are not using target, terraform will attempt to deploy all uncreated resources
apply-nodes:
	terraform apply -auto-approve

# 3. Destroy nodes: keep the template by specifying targets
destroy-nodes:
	terraform destroy -target=module.master_node -target=module.worker_node -auto-approve

# 4. Clean
clean:
	rm -rf .terraform .terraform.lock.hcl
	
deploy:
	terraform apply -parallelism=1