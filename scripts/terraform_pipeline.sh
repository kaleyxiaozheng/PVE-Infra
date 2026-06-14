#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD_WHITE='\033[1;37m'
BOLD_YELLOW='\033[1;33m'
BOLD_RED='\033[1;31m'
BOLD_GREEN='\033[1;32m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
} 

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_info "Starting Terraform provisioning pipeline..."
terraform init

log_info "Provisioning S3 bucket..."
terraform apply -target=aws_s3_bucket.aegis_logic_s3_bucket -auto-approve

log_success "Successfully provisioned S3 bucket. Current S3 state:  "
terraform state list | grep s3

#!/bin/bash
# terraform_pipeline.sh

terraform init

# 2. 
# ./terraform_pipeline.sh s3 (only deploy S3)
# ./terraform_pipeline.sh all (deploy everything)

ACTION=$1

case $ACTION in
    s3)
        echo "Deploying S3..."
        terraform apply -target=aws_s3_bucket.my_s3_bucket -auto-approve
        ;;
    db)
        echo "Deploying DynamoDB..."
        terraform apply -target=aws_dynamodb_table.my_dynamodb_table -auto-approve
        ;;
    all)
        echo "Deploying everything..."
        terraform apply -auto-approve
        ;;
    *)
        echo "Usage: ./terraform_pipeline.sh [s3|db|all]"
        ;;
esac