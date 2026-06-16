#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }

log_info "Initializing Terraform..."
terraform init

ACTION=${1:-"all"} # default if no argument is passed, execute all

case $ACTION in
    s3)
        log_info "Deploying S3 state bucket..."
        terraform apply -target=aws_s3_bucket.aegis_logic_terraform_state_bucket -auto-approve
        ;;
    all)
        log_info "Deploying entire infrastructure..."
        terraform apply -auto-approve
        ;;
    *)
        echo "Usage: ./terraform_pipeline.sh [s3|all]"
        exit 1
        ;;
esac