resource "random_id" "random_prefix" {
  byte_length = 8
}

resource "aws_apprunner_service" "this" {
  service_name = var.service_name

  source_configuration {
    dynamic "authentication_configuration" {
      for_each = var.image_repository_type == "ECR" ? [1] : []
      content {
        access_role_arn = aws_iam_role.app_runner_access_role.arn
      }
    }

    image_repository {
      image_configuration {
        port                          = var.port
        runtime_environment_secrets   = var.runtime_environment_secrets
        runtime_environment_variables = var.runtime_environment_variables
      }
      image_identifier      = "${var.image_repository_source}:${var.image_repository_tag}"
      image_repository_type = var.image_repository_type
    }
    auto_deployments_enabled = var.auto_deployments_enabled
  }

  network_configuration {
    ingress_configuration {
      is_publicly_accessible = var.is_publicly_accessible
    }

    dynamic "egress_configuration" {
      for_each = var.vpc_connector_arn != "" ? [1] : []
      content {
        egress_type       = "VPC"
        vpc_connector_arn = var.vpc_connector_arn
      }
    }
  }

  observability_configuration {
    observability_enabled           = true
    observability_configuration_arn = aws_apprunner_observability_configuration.this.arn
  }

  health_check_configuration {
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    unhealthy_threshold = var.health_check_unhealthy_treshold
    healthy_threshold   = var.health_check_healthy_treshold
    protocol            = var.health_check_protocol
    path                = var.health_check_path
  }

  instance_configuration {
    instance_role_arn = aws_iam_role.app_runner_instance_role.arn
    cpu               = var.cpu
    memory            = var.memory
  }

  depends_on = [
    aws_iam_role.app_runner_instance_role,
    aws_iam_role.app_runner_access_role
  ]

  lifecycle {
    ignore_changes = [
      source_configuration[0].image_repository[0].image_identifier
    ]
  }

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.this.arn

  tags = var.tags
}

resource "aws_apprunner_auto_scaling_configuration_version" "this" {
  auto_scaling_configuration_name = "${random_id.random_prefix.hex}-autoscaling"

  max_concurrency = var.autoscaling_max_concurrency
  max_size        = var.autoscaling_max_size
  min_size        = var.autoscaling_min_size

  tags = var.tags
}

resource "aws_apprunner_observability_configuration" "this" {
  observability_configuration_name = "${random_id.random_prefix.hex}-xray"

  trace_configuration {
    vendor = "AWSXRAY"
  }
}

resource "aws_apprunner_custom_domain_association" "this" {
  count                = var.use_custom_domain ? 1 : 0
  domain_name          = var.domain_name
  service_arn          = aws_apprunner_service.this.arn
  enable_www_subdomain = false
}

resource "aws_wafv2_web_acl_association" "this" {
  count = var.associate_waf ? 1 : 0

  resource_arn = aws_apprunner_service.this.arn
  web_acl_arn  = var.waf_arn
}
