
resource "aws_cloudwatch_metric_alarm" "app_runner_cpu_utilization" {
  alarm_name          = "${var.service_name}-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/AppRunner"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This alarm triggers when CPU utilization exceeds 80% for 15 minutes"
  treat_missing_data  = "ignore"

  dimensions = {
    ServiceName = aws_apprunner_service.this.service_name
    ServiceID   = aws_apprunner_service.this.service_id
  }

  alarm_actions = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
  ok_actions    = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_runner_memory_utilization" {
  alarm_name          = "${var.service_name}-memory-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/AppRunner"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This alarm triggers when memory utilization exceeds 80% for 15 minutes"
  treat_missing_data  = "ignore"

  dimensions = {
    ServiceName = aws_apprunner_service.this.service_name
    ServiceID   = aws_apprunner_service.this.service_id
  }

  alarm_actions = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
  ok_actions    = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_runner_5xx_errors" {
  alarm_name          = "${var.service_name}-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "5xxStatusResponses"
  namespace           = "AWS/AppRunner"
  period              = 300
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "This alarm triggers when there are more than 10 5xx errors in 10 minutes"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ServiceName = aws_apprunner_service.this.service_name
    ServiceID   = aws_apprunner_service.this.service_id
  }

  alarm_actions = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
  ok_actions    = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_runner_4xx_errors" {
  alarm_name          = "${var.service_name}-4xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "4xxStatusResponses"
  namespace           = "AWS/AppRunner"
  period              = 300
  statistic           = "Sum"
  threshold           = 50
  alarm_description   = "This alarm triggers when there are more than 50 4xx errors in 10 minutes"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ServiceName = aws_apprunner_service.this.service_name
    ServiceID   = aws_apprunner_service.this.service_id
  }

  alarm_actions = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
  ok_actions    = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_runner_latency" {
  alarm_name          = "${var.service_name}-request-latency"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "RequestLatency"
  namespace           = "AWS/AppRunner"
  period              = 300
  statistic           = "Average"
  threshold           = 1000
  alarm_description   = "This alarm triggers when average request latency exceeds 1000ms for 15 minutes"
  treat_missing_data  = "ignore"

  dimensions = {
    ServiceName = aws_apprunner_service.this.service_name
    ServiceID   = aws_apprunner_service.this.service_id
  }

  alarm_actions = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
  ok_actions    = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_runner_error_rate" {
  alarm_name          = "${var.service_name}-error-rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  threshold           = 5
  alarm_description   = "This alarm triggers when error rate exceeds 5% for 10 minutes"
  treat_missing_data  = "ignore"

  metric_query {
    id          = "e1"
    expression  = "m2"
    label       = "ErrorCount"
    return_data = false
  }

  metric_query {
    id = "m1"
    metric {
      metric_name = "Requests"
      namespace   = "AWS/AppRunner"
      period      = 300
      stat        = "Sum"
      dimensions = {
        ServiceName = aws_apprunner_service.this.service_name
        ServiceID   = aws_apprunner_service.this.service_id
      }
    }
    return_data = false
  }

  metric_query {
    id = "m2"
    metric {
      metric_name = "5xxStatusResponses"
      namespace   = "AWS/AppRunner"
      period      = 300
      stat        = "Sum"
      dimensions = {
        ServiceName = aws_apprunner_service.this.service_name
        ServiceID   = aws_apprunner_service.this.service_id
      }
    }
    return_data = false
  }

  metric_query {
    id          = "e2"
    expression  = "100*(e1/m1)"
    label       = "Error Rate (%)"
    return_data = true
  }

  alarm_actions = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
  ok_actions    = [aws_sns_topic.apprunner_cloudwatch_notifications.arn]
}
