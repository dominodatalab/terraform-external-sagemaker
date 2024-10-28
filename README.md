# terraform-external-sagemaker

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.role_permissions_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.domino_sagemaker_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.role_permissions_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.role_permissions_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.role_trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | S3 bucket to use for sagemaker deployment model artifacts (in the target AWS account).  Defaults to the value specified by `resource_identifier` plus the suffix `-{aws_account_id}.` | `string` | n/a | yes |
| <a name="input_domino_external_deployments_role_arn"></a> [domino\_external\_deployments\_role\_arn](#input\_domino\_external\_deployments\_role\_arn) | ARN for the Domino external deployments IAM role (in the domino AWS account) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region in which to create the sagemaker resources | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | ECR repository name to use for sagemaker deployment images (in the target AWS account).  Defaults to the value specified by `resource_identifier`. | `string` | n/a | yes |
| <a name="input_resource_identifier"></a> [resource\_identifier](#input\_resource\_identifier) | identifier for domino-created resources in the AWS account | `string` | `"domino-sagemaker"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | IAM role name to use for creating sagemaker deployment resources (in the target AWS account).  Defaults to the value specified by `resource_identifier`. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sagemaker"></a> [sagemaker](#output\_sagemaker) | Domino sagemaker deployments info |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
