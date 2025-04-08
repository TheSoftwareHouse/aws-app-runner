data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "app_runner_instance_role_assume_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["tasks.apprunner.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole",
    ]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "app_runner_access_role_assume_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["build.apprunner.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole",
    ]
    effect = "Allow"
  }
}

locals {
  all_secret_arns     = values(var.runtime_environment_secrets)
  secretsmanager_arns = [for arn in local.all_secret_arns : strcontains(arn, ":ssm:") ? arn : null]
  ssm_parameter_arns  = [for arn in local.all_secret_arns : strcontains(arn, ":ssm:") ? arn : null]
}

data "aws_iam_policy_document" "app_runner_instance_policy" {
  dynamic "statement" {
    for_each = length(var.application_buckets) > 0 ? [1] : []
    content {
      sid    = "S3ListBucketPolicy"
      effect = "Allow"
      actions = [
        "s3:ListBucket",
      ]
      resources = [for bucket in var.application_buckets : "arn:aws:s3:::${bucket}"]
    }
  }

  dynamic "statement" {
    for_each = length(var.application_buckets) > 0 ? [1] : []
    content {
      sid    = "S3ObjectsPolicy"
      effect = "Allow"
      actions = [
        "s3:Get*",
        "s3:Put*"
      ]
      resources = [for bucket in var.application_buckets : "arn:aws:s3:::${bucket}/*"]
    }
  }

  dynamic "statement" {
    for_each = length(local.secretsmanager_arns) > 0 ? [1] : []
    content {
      sid    = "SecretManagerPolicy"
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue",
      ]
      resources = local.secretsmanager_arns
    }
  }

  dynamic "statement" {
    for_each = length(local.ssm_parameter_arns) > 0 ? [1] : []
    content {
      sid    = "SSMPolicy"
      effect = "Allow"
      actions = [
        "ssm:GetParameter",
        "ssm:GetParameters",
      ]
      resources = local.ssm_parameter_arns
    }
  }
}

data "aws_iam_policy_document" "app_runner_access_policy" {
  statement {
    sid    = "ReadPrivateECR"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchImportUpstreamImage"
    ]

    resources = ["*"]
  }
}
