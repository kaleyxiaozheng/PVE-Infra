# s3_bucket.tf

resource "aws_s3_bucket" "aegis_logic_terraform_state_bucket" {
  provider = aws.sydney
  bucket = "${local.project_prefix}-${local.common_tags.ManagedBy}-state-bucket"
}