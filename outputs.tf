output "sagemaker" {
  description = "Domino sagemaker deployments info"
  value = {
    account_id = local.account_id
    role_arn   = aws_iam_role.domino_sagemaker_role.arn
    repository = local.repository
    bucket     = local.bucket
    region     = var.region
  }
}
