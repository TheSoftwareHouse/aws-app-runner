variable "aws_region" {
  type        = string
  description = "Primary region for AWS App Runner"
  default     = "eu-west-1"
}
variable "auto_deployments_enabled" {
  type        = bool
  description = "Enable automatic deployments after image tag push (tag has to be the same all the time, for example 'latest')"
  default     = true
}

variable "autoscaling_max_concurrency" {
  type        = number
  default     = 3
  description = "The maximum number of concurrent requests that App Runner can process per instance."
}

variable "autoscaling_max_size" {
  type        = number
  default     = 3
  description = "The maximum number of instances that App Runner can scale up to."
}

variable "autoscaling_min_size" {
  type        = number
  default     = 1
  description = "The minimum number of instances that App Runner should maintain."
}

variable "image_repository_source" {
  type        = string
  default     = "public.ecr.aws/aws-containers/hello-app-runner"
  description = "The URL of the container image repository used by App Runner."
}

variable "image_repository_tag" {
  type        = string
  default     = "latest"
  description = "The tag of the container image to be deployed."
}

variable "image_repository_type" {
  type        = string
  default     = "ECR"
  description = "The type of image repository, e.g., 'ECR' for Elastic Container Registry."
}

variable "port" {
  type        = number
  default     = 8000 # port for hello-app-runner image
  description = "The port on which the application listens for incoming requests."
}

variable "use_custom_domain" {
  type        = bool
  default     = false
  description = "Use custom domain for your AppRunner service (true/false)? Note, that this will create DNS records you have to add to your DNS provider"
}

variable "domain_name" {
  type        = string
  default     = ""
  description = "The custom domain name to be associated with the App Runner service."
}

variable "health_check_healthy_treshold" {
  type        = number
  default     = 1
  description = "The number of consecutive successful health checks before considering the instance healthy."
}

variable "health_check_interval" {
  type        = number
  default     = 15
  description = "The interval, in seconds, between health checks."
}

variable "health_check_timeout" {
  type        = number
  default     = 15
  description = "The time, in seconds, before a health check is considered a failure."
}

variable "health_check_unhealthy_treshold" {
  type        = number
  default     = 3
  description = "The number of consecutive failed health checks before considering the instance unhealthy."
}

variable "health_check_protocol" {
  type        = string
  default     = "HTTP"
  description = "The protocol used for health checks (HTTP or TCP)."
}

variable "health_check_path" {
  type        = string
  default     = "/"
  description = "The path to be used for HTTP health checks."
}

variable "service_name" {
  type        = string
  description = "The name of the App Runner service."
}

variable "is_publicly_accessible" {
  type        = bool
  description = "Is this service accessible from Internet"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the App Runner resources."
}

variable "send_deployment_notifications_to_slack" {
  type        = bool
  description = "Do you want to send deployment notifications to Slack (true/false)?"
  default     = false
}

variable "send_cloudwatch_notifications_to_slack" {
  type        = bool
  description = "Do you want to send Cloudwatch Alarm notifications to Slack (true/false)?"
  default     = false
}

variable "deployments_slack_webhook_url" {
  type        = string
  default     = ""
  description = "The webhook URL for sending deployment notifications to Slack."
}

variable "deployments_slack_channel" {
  type        = string
  default     = ""
  description = "The Slack channel where deployment notifications should be sent."
}

variable "deployments_slack_username" {
  type        = string
  default     = "AWS App Runner Deployment"
  description = "The username that should appear for deployment Slack notifications."
}

variable "cloudwatch_alarms_slack_webhook_url" {
  type        = string
  default     = ""
  description = "The webhook URL for sending Cloudwatch Alarms notifications to Slack."
}

variable "cloudwatch_alarms_slack_channel" {
  type        = string
  default     = ""
  description = "The Slack channel where Cloudwatch Alarms notifications should be sent."
}

variable "cloudwatch_alarms_slack_username" {
  type        = string
  default     = "AWS App Runner Cloudwatch Alarm"
  description = "The username that should appear for Cloudwatch Alarms Slack notifications."
}

variable "vpc_connector_arn" {
  type        = string
  default     = ""
  description = "The ARN of the VPC connector used to enable network access for the service. If left empty, the service will not be connected to a VPC."
}

variable "cpu" {
  type        = string
  default     = "2 vCPU"
  description = "The number of vCPUs allocated for the App Runner service."
}

variable "memory" {
  type        = number
  default     = 4096
  description = "The amount of memory (in MB) allocated for the App Runner service."
}

variable "runtime_environment_secrets" {
  type        = map(any)
  description = "Map of objects to be used as environmental variables coming from AWS Secret Manager and AWS SSM Parameter Store"
  default     = {}
}

variable "runtime_environment_variables" {
  type        = map(any)
  description = "Map of simple environmental variables that are static and defined in Terraform code"
  default     = {}
}

variable "application_buckets" {
  type        = list(string)
  description = "Buckets where application will store data"
  default     = []
}

variable "associate_waf" {
  type        = bool
  default     = false
  description = "Associate WAF with App Runner service"
}

variable "waf_arn" {
  type        = string
  description = "Web ACL ARN of WAF to associate"
  default     = ""
}
