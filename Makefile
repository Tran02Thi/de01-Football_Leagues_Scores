PIPELINE_DIR := pipeline


.PHONY: build infrastructure
build infrastructure: 
	cd $(PIPELINE_DIR) && terraform init && terraform apply -auto-approve


.PHONY: build data-lake
build data-lake:
	cd $(PIPELINE_DIR) && terraform -chdir=data-lake/ init && terraform -chdir=data-lake/ apply 


.PHONY: build data-warehouse
build data-warehouse:
	cd $(PIPELINE_DIR) && terraform -chdir=data-warehouse/ init && terraform -chdir=data-warehouse/ apply -var-file .tfvars


.PHONY: build data-lakehouse
build data-lakehouse:
	cd $(PIPELINE_DIR) && terraform -chdir=data-lakehouse/ init && terraform -chdir=data-lakehouse/ apply
