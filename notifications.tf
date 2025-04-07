resource "aws_cloudwatch_event_rule" "apprunner_deploy_notifications" {
  name          = "${var.service_name}-deploy-notifications"
  description   = "Monitor App Runner Deploy Notifications"
  event_pattern = templatefile("${path.module}/event_pattern.tpl", { aws_account_id = data.aws_caller_identity.current.account_id })
  state         = "ENABLED"
}

resource "aws_sns_topic" "apprunner_deployment_notifications" {
  name = "${var.service_name}-deployment-notifications"
  tags = var.tags
}

resource "aws_sns_topic" "apprunner_cloudwatch_notifications" {
  name = "${var.service_name}-cloudwatch-notifications"
  tags = var.tags
}

resource "aws_cloudwatch_event_target" "apprunner_deploy_notifications" {
  target_id = "${var.service_name}-deployment-notifications"
  rule      = aws_cloudwatch_event_rule.apprunner_deploy_notifications.name
  arn       = aws_sns_topic.apprunner_deployment_notifications.arn
}

resource "aws_sns_topic_policy" "apprunner_deployment_notifications" {
  arn    = aws_sns_topic.apprunner_deployment_notifications.arn
  policy = data.aws_iam_policy_document.apprunner_deployment_notifications.json
}

data "aws_iam_policy_document" "apprunner_deployment_notifications" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.current.account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.apprunner_deployment_notifications.arn
    ]

    sid = "__default_statement_ID"
  }

  statement {
    actions = [
      "SNS:Publish"
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.apprunner_deployment_notifications.arn
    ]

    sid = "__AllowNotificationsFromAppRunner"
  }
}

data "aws_iam_policy_document" "apprunner_cloudwatch_notifications" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.current.account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.apprunner_cloudwatch_notifications.arn
    ]

    sid = "__default_statement_ID"
  }

  statement {
    actions = [
      "SNS:Publish"
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.apprunner_cloudwatch_notifications.arn
    ]

    sid = "__AllowNotificationsFromAppRunner"
  }
}

module "notify_slack_deployments" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "6.5.2"

  create = var.send_deployment_notifications_to_slack

  sns_topic_name   = aws_sns_topic.apprunner_deployment_notifications.name
  create_sns_topic = false

  recreate_missing_package = false

  slack_webhook_url    = var.deployments_slack_webhook_url
  slack_channel        = var.deployments_slack_channel
  slack_username       = var.deployments_slack_username
  lambda_function_name = "${var.service_name}-dpl"
  iam_role_name_prefix = "tsh"

  tags = var.tags
}

module "notify_cloudwatch_alarms" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "6.5.2"

  create = var.send_cloudwatch_notifications_to_slack

  sns_topic_name   = aws_sns_topic.apprunner_cloudwatch_notifications.name
  create_sns_topic = false

  recreate_missing_package = false

  slack_webhook_url    = var.cloudwatch_alarms_slack_webhook_url
  slack_channel        = var.cloudwatch_alarms_slack_channel
  slack_username       = var.cloudwatch_alarms_slack_username
  lambda_function_name = "${var.service_name}-cw"
  iam_role_name_prefix = "tsh"

  tags = var.tags
}
