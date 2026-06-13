terraform {
  backend "s3" {
    bucket         = "你的-s3-bucket-名称"
    key            = "pve-cluster/terraform.tfstate"
    region         = "ap-southeast-2"                
    encrypt        = true
  }
}

terraform {
  backend "s3" {
    bucket         = "${local.project_prefix}-${local.common_tags.ManagedBy}-bucket"
    key            = "terraform.tfstate"            # path in the bucket to store the state file
    region         = "ap-southeast-2"               
    dynamodb_table = "${local.project_prefix}-${local.common_tags.Environment}-lock"     
    encrypt        = true                           
  }
}