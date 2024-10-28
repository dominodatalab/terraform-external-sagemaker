data "aws_iam_policy_document" "role_permissions_policy" {
  statement {
    sid     = "StsAllowSelfAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:${data.aws_partition.current.partition}:iam::${local.account_id}:role/${local.role_name}"
    ]
  }
  statement {
    sid    = "IamAllowPassRole"
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:PassRole",
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:iam::${local.account_id}:role/${local.role_name}"
    ]
  }
  statement {
    sid    = "EcrRegistrySpecificSagemakerEnvironments"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchDeleteImage",
      "ecr:BatchGetImage",
      "ecr:CreateRepository",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:TagResource",
      "ecr:UploadLayerPart",
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:ecr:${var.region}:${local.account_id}:repository/${local.repository}",
      "arn:${data.aws_partition.current.partition}:ecr:${var.region}:${local.account_id}:repository/${local.repository}*"
    ]
  }
  statement {
    sid    = "EcrGlobalSagemakerEnvironments"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:DescribeRegistry"
    ]
    resources = ["*"]
  }
  statement {
    sid       = "MetricsForSagemaker"
    effect    = "Allow"
    actions   = ["cloudwatch:PutMetricData"]
    resources = ["*"]
  }
  statement {
    sid    = "LogsForSagemaker"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:GetLogEvents",
      "logs:FilterLogEvents"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:logs:${var.region}:${local.account_id}:log-group:/aws/sagemaker/*"
    ]
  }
  statement {
    sid    = "SagemakerManageResources"
    effect = "Allow"
    actions = [
      "sagemaker:AddTags",
      "sagemaker:CreateEndpoint",
      "sagemaker:CreateEndpointConfig",
      "sagemaker:CreateModel",
      "sagemaker:DeleteEndpoint",
      "sagemaker:DeleteEndpointConfig",
      "sagemaker:DeleteModel",
      "sagemaker:DeleteTags",
      "sagemaker:DescribeEndpoint",
      "sagemaker:DescribeEndpointConfig",
      "sagemaker:DescribeModel",
      "sagemaker:InvokeEndpoint",
      "sagemaker:InvokeEndpointWithResponseStream",
      "sagemaker:UpdateEndpoint",
      "sagemaker:UpdateEndpointWeightsAndCapacities"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AutoscalingForSagemaker"
    effect = "Allow"
    actions = [
      "application-autoscaling:DeleteScalingPolicy",
      "application-autoscaling:DeregisterScalableTarget",
      "application-autoscaling:DescribeScalableTargets",
      "application-autoscaling:DescribeScalingActivities",
      "application-autoscaling:DescribeScalingPolicies",
      "application-autoscaling:PutScalingPolicy",
      "application-autoscaling:RegisterScalableTarget",
      "application-autoscaling:TagResource"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "CloudwatchForAutoscaling"
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DeleteAlarms",
      "cloudwatch:DescribeAlarms"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid    = "IamAllowCreateServiceLinkedRole"
    effect = "Allow"
    actions = [
      "iam:CreateServiceLinkedRole"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:iam::${local.account_id}:role/aws-service-role/sagemaker.application-autoscaling.amazonaws.com/*"
    ]
    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values = [
        "sagemaker.application-autoscaling.amazonaws.com"
      ]
    }
  }
  statement {
    sid    = "S3ManageUseTargetBucket"
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:DeleteObject",
      "s3:DeleteObjectTagging",
      "s3:DeleteObjectVersionTagging",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectTagging",
      "s3:GetObjectRetention",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:PutBucketObjectLockConfiguration",
      "s3:PutBucketTagging",
      "s3:PutBucketVersioning",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectTagging",
      "s3:PutObjectVersionAcl",
      "s3:PutObjectVersionTagging",
      "s3:PutObjectRetention"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:s3:::${local.bucket}",
      "arn:${data.aws_partition.current.partition}:s3:::${local.bucket}/*"
    ]
  }
}

resource "aws_iam_policy" "role_permissions_policy" {
  name   = "${var.resource_identifier}-permissions"
  policy = data.aws_iam_policy_document.role_permissions_policy.json
}

resource "aws_iam_role_policy_attachment" "role_permissions_policy" {
  role       = aws_iam_role.domino_sagemaker_role.name
  policy_arn = aws_iam_policy.role_permissions_policy.arn
}
