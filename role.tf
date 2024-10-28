data "aws_iam_policy_document" "role_trust_policy" {
  statement {
    sid     = "SelfAssumeRole"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${local.account_id}:root"
      ]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:PrincipalArn"
      values = [
        "arn:${data.aws_partition.current.partition}:iam::${local.account_id}:role/${local.role_name}"
      ]
    }
  }
  statement {
    sid     = "SagemakerAssumeRole"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
  statement {
    sid     = "DominoAssumeRole"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        var.domino_external_deployments_role_arn,
      ]
    }
  }
}


resource "aws_iam_role" "domino_sagemaker_role" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.role_trust_policy.json
}
