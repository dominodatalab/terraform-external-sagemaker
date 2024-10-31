output "resource_identifier" {
  description = "test resource identifier"
  value       = random_id.resource_identifier.id
}

output "aws_partition" {
  description = "test aws partition"
  value       = data.aws_partition.current.partition
}

output "domino_external_deployments_role_arn" {
  description = "test domino external deployments role ARN"
  value       = aws_iam_role.domino_external_deployments_role.arn
}
