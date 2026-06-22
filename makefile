# Makefile
init:
	terraform init

plan:
	terraform plan
	
deploy:
	terraform apply -parallelism=1