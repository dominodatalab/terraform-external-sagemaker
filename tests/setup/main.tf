data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  role_name = "${random_id.resource_identifier.id}-domino-role"
}

resource "random_id" "resource_identifier" {
  byte_length = 4
}

data "aws_iam_policy_document" "self_assume_role" {
  statement {
    sid     = "SelfAssumeRole"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:PrincipalArn"
      values = [
        "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role/${local.role_name}"
      ]
    }
  }
}

resource "aws_iam_role" "domino_external_deployments_role" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.self_assume_role.json
}
