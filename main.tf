data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  repository = coalesce(var.repository, var.resource_identifier)
  bucket     = coalesce(var.bucket, "${var.resource_identifier}-${local.account_id}")
  role_name  = coalesce(var.role_name, var.resource_identifier)
}
