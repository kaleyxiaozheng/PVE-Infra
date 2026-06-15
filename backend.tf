terraform {
  backend "s3" {
    bucket = "aegis-logic-terraform-state-bucket"
    key    = "terraform.tfstate" # path in the bucket to store the state file
    region = "ap-southeast-2"
    use_lockfile = true
    encrypt      = true
  }
}