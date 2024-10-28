variable "resource_identifier" {
  type        = string
  description = "identifier for domino-created resources in the AWS account"
  nullable    = false
  default     = "domino-sagemaker"
}

variable "domino_external_deployments_role_arn" {
  type        = string
  description = "ARN for the Domino external deployments IAM role (in the domino AWS account)"
  nullable    = false
}

variable "region" {
  type        = string
  description = "AWS region in which to create the sagemaker resources"
  nullable    = false
  validation {
    condition     = can(regex("(us(-gov)?|ap|ca|cn|eu|sa|me|af|il)-(central|(north|south)?(east|west)?)-[0-9]", var.region))
    error_message = "The provided region must follow the format of AWS region names, e.g., us-west-2, us-gov-west-1."
  }
}

variable "repository" {
  type        = string
  description = "ECR repository name to use for sagemaker deployment images (in the target AWS account).  Defaults to the value specified by `resource_identifier`."
  nullable    = true
  default     = null
}

variable "bucket" {
  type        = string
  description = "S3 bucket to use for sagemaker deployment model artifacts (in the target AWS account).  Defaults to the value specified by `resource_identifier` plus the suffix `-{aws_account_id}.`"
  nullable    = true
  default     = null
}

variable "role_name" {
  type        = string
  description = "IAM role name to use for creating sagemaker deployment resources (in the target AWS account).  Defaults to the value specified by `resource_identifier`."
  nullable    = true
  default     = null
}
