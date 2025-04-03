resource "aws_cloudwatch_dashboard" "app_runner_dashboard" {
  dashboard_name = "${var.service_name}-app-runner"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 1
        properties = {
          markdown = "# App Runner Service: ${var.service_name}"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 1
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/AppRunner", "CPUUtilization", "ServiceName", var.service_name, "ServiceID", aws_apprunner_service.this.service_id]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "CPU Utilization (%)"
          period  = 300
          stat    = "Average"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 1
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/AppRunner", "MemoryUtilization", "ServiceName", var.service_name, "ServiceID", aws_apprunner_service.this.service_id]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "Memory Utilization (%)"
          period  = 300
          stat    = "Average"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 7
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/AppRunner", "Requests", "ServiceName", var.service_name, "ServiceID", aws_apprunner_service.this.service_id]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "Total Requests"
          period  = 300
          stat    = "Sum"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 7
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/AppRunner", "RequestLatency", "ServiceName", var.service_name, "ServiceID", aws_apprunner_service.this.service_id]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "Request Latency (ms)"
          period  = 300
          stat    = "Average"
          yAxis = {
            left = {
              min = 0
            }
          }
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 13
        width  = 24
        height = 6
        properties = {
          metrics = [
            ["AWS/AppRunner", "2xxStatusResponses", "ServiceName", aws_apprunner_service.this.service_name, "ServiceID", aws_apprunner_service.this.service_id],
            ["AWS/AppRunner", "4xxStatusResponses", "ServiceName", aws_apprunner_service.this.service_name, "ServiceID", aws_apprunner_service.this.service_id],
            ["AWS/AppRunner", "5xxStatusResponses", "ServiceName", aws_apprunner_service.this.service_name, "ServiceID", aws_apprunner_service.this.service_id]
          ]
          view    = "timeSeries"
          stacked = true
          region  = var.aws_region
          title   = "HTTP Status Codes"
          period  = 300
          stat    = "Sum"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 19
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/AppRunner", "ActiveInstances", "ServiceName", aws_apprunner_service.this.service_name, "ServiceID", aws_apprunner_service.this.service_id]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "Active Instances"
          period  = 300
          stat    = "Average"
          yAxis = {
            left = {
              min = 0
            }
          }
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 19
        width  = 12
        height = 6
        properties = {
          metrics = [
            [{ expression = "(m3)/(m1*100)", label = "Error Rate (%)", id = "e1" }],
            ["AWS/AppRunner", "Requests", "ServiceName", aws_apprunner_service.this.service_name, "ServiceID", aws_apprunner_service.this.service_id, { id = "m1", visible = false }],
            ["AWS/AppRunner", "5xxStatusResponses", "ServiceName", aws_apprunner_service.this.service_name, "ServiceID", aws_apprunner_service.this.service_id, { id = "m3", visible = false }]
          ],
          view    = "timeSeries",
          stacked = false,
          region  = var.aws_region,
          title   = "Error Rate (%)",
          period  = 300
        }
      }
    ]
  })
}
