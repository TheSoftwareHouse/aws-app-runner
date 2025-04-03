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

data "aws_iam_policy_document" "app_runner_instance_policy" {
  statement {
    sid    = "S3ListBucketPolicy"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]
    resources = [for bucket in var.application_buckets : "arn:aws:s3:::${bucket}"]
  }

  statement {
    sid    = "S3ObjectsPolicy"
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:Put*"
    ]
    resources = [for bucket in var.application_buckets : "arn:aws:s3:::${bucket}/*"]
  }



  statement {
    sid    = "SecretManagerPolicy"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = ["arn:aws:secretsmanager:*:*:secret:${var.service_name}*"]
  }
  statement {
    sid    = "SSMPolicy"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
    ]
    resources = ["arn:aws:ssm:*:*:parameter/${var.service_name}*"]
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
