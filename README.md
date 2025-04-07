## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.8 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_notify_cloudwatch_alarms"></a> [notify\_cloudwatch\_alarms](#module\_notify\_cloudwatch\_alarms) | terraform-aws-modules/notify-slack/aws | 6.5.2 |
| <a name="module_notify_slack_deployments"></a> [notify\_slack\_deployments](#module\_notify\_slack\_deployments) | terraform-aws-modules/notify-slack/aws | 6.5.2 |

## Resources

| Name | Type |
|------|------|
| [aws_apprunner_auto_scaling_configuration_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_auto_scaling_configuration_version) | resource |
| [aws_apprunner_custom_domain_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_custom_domain_association) | resource |
| [aws_apprunner_observability_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_observability_configuration) | resource |
| [aws_apprunner_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_service) | resource |
| [aws_cloudwatch_dashboard.app_runner_dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard) | resource |
| [aws_cloudwatch_event_rule.apprunner_deploy_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.apprunner_deploy_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_metric_alarm.app_runner_4xx_errors](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.app_runner_5xx_errors](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.app_runner_cpu_utilization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.app_runner_error_rate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.app_runner_latency](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.app_runner_memory_utilization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_policy.app_runner_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.app_runner_instance_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.app_runner_access_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.app_runner_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.app_runner_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.app_runner_instance_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_sns_topic.apprunner_cloudwatch_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic.apprunner_deployment_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.apprunner_deployment_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_wafv2_web_acl_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.app_runner_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.app_runner_access_role_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.app_runner_instance_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.app_runner_instance_role_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.apprunner_cloudwatch_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.apprunner_deployment_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_buckets"></a> [application\_buckets](#input\_application\_buckets) | Buckets where application will store data | `list(string)` | `[]` | no |
| <a name="input_associate_waf"></a> [associate\_waf](#input\_associate\_waf) | Associate WAF with App Runner service | `bool` | `false` | no |
| <a name="input_auto_deployments_enabled"></a> [auto\_deployments\_enabled](#input\_auto\_deployments\_enabled) | Enable automatic deployments after image tag push (tag has to be the same all the time, for example 'latest') | `bool` | `true` | no |
| <a name="input_autoscaling_max_concurrency"></a> [autoscaling\_max\_concurrency](#input\_autoscaling\_max\_concurrency) | The maximum number of concurrent requests that App Runner can process per instance. | `number` | `3` | no |
| <a name="input_autoscaling_max_size"></a> [autoscaling\_max\_size](#input\_autoscaling\_max\_size) | The maximum number of instances that App Runner can scale up to. | `number` | `3` | no |
| <a name="input_autoscaling_min_size"></a> [autoscaling\_min\_size](#input\_autoscaling\_min\_size) | The minimum number of instances that App Runner should maintain. | `number` | `1` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Primary region for AWS App Runner | `string` | `"eu-west-1"` | no |
| <a name="input_cloudwatch_alarms_slack_channel"></a> [cloudwatch\_alarms\_slack\_channel](#input\_cloudwatch\_alarms\_slack\_channel) | The Slack channel where Cloudwatch Alarms notifications should be sent. | `string` | `""` | no |
| <a name="input_cloudwatch_alarms_slack_username"></a> [cloudwatch\_alarms\_slack\_username](#input\_cloudwatch\_alarms\_slack\_username) | The username that should appear for Cloudwatch Alarms Slack notifications. | `string` | `"AWS App Runner Cloudwatch Alarm"` | no |
| <a name="input_cloudwatch_alarms_slack_webhook_url"></a> [cloudwatch\_alarms\_slack\_webhook\_url](#input\_cloudwatch\_alarms\_slack\_webhook\_url) | The webhook URL for sending Cloudwatch Alarms notifications to Slack. | `string` | `""` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of vCPUs allocated for the App Runner service. | `string` | `"2 vCPU"` | no |
| <a name="input_deployments_slack_channel"></a> [deployments\_slack\_channel](#input\_deployments\_slack\_channel) | The Slack channel where deployment notifications should be sent. | `string` | `""` | no |
| <a name="input_deployments_slack_username"></a> [deployments\_slack\_username](#input\_deployments\_slack\_username) | The username that should appear for deployment Slack notifications. | `string` | `"AWS App Runner Deployment"` | no |
| <a name="input_deployments_slack_webhook_url"></a> [deployments\_slack\_webhook\_url](#input\_deployments\_slack\_webhook\_url) | The webhook URL for sending deployment notifications to Slack. | `string` | `""` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The custom domain name to be associated with the App Runner service. | `string` | `""` | no |
| <a name="input_health_check_healthy_treshold"></a> [health\_check\_healthy\_treshold](#input\_health\_check\_healthy\_treshold) | The number of consecutive successful health checks before considering the instance healthy. | `number` | `1` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | The interval, in seconds, between health checks. | `number` | `15` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The path to be used for HTTP health checks. | `string` | `"/"` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | The protocol used for health checks (HTTP or TCP). | `string` | `"HTTP"` | no |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | The time, in seconds, before a health check is considered a failure. | `number` | `15` | no |
| <a name="input_health_check_unhealthy_treshold"></a> [health\_check\_unhealthy\_treshold](#input\_health\_check\_unhealthy\_treshold) | The number of consecutive failed health checks before considering the instance unhealthy. | `number` | `3` | no |
| <a name="input_image_repository_source"></a> [image\_repository\_source](#input\_image\_repository\_source) | The URL of the container image repository used by App Runner. | `string` | `"public.ecr.aws/aws-containers/hello-app-runner"` | no |
| <a name="input_image_repository_tag"></a> [image\_repository\_tag](#input\_image\_repository\_tag) | The tag of the container image to be deployed. | `string` | `"latest"` | no |
| <a name="input_image_repository_type"></a> [image\_repository\_type](#input\_image\_repository\_type) | The type of image repository, e.g., 'ECR' for Elastic Container Registry. | `string` | `"ECR"` | no |
| <a name="input_is_publicly_accessible"></a> [is\_publicly\_accessible](#input\_is\_publicly\_accessible) | Is this service accessible from Internet | `bool` | `true` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory (in MB) allocated for the App Runner service. | `number` | `4096` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the application listens for incoming requests. | `number` | `8000` | no |
| <a name="input_runtime_environment_secrets"></a> [runtime\_environment\_secrets](#input\_runtime\_environment\_secrets) | Map of objects to be used as environmental variables coming from AWS Secret Manager and AWS SSM Parameter Store | `map(any)` | `{}` | no |
| <a name="input_runtime_environment_variables"></a> [runtime\_environment\_variables](#input\_runtime\_environment\_variables) | Map of simple environmental variables that are static and defined in Terraform code | `map(any)` | `{}` | no |
| <a name="input_send_cloudwatch_notifications_to_slack"></a> [send\_cloudwatch\_notifications\_to\_slack](#input\_send\_cloudwatch\_notifications\_to\_slack) | Do you want to send Cloudwatch Alarm notifications to Slack (true/false)? | `bool` | `false` | no |
| <a name="input_send_deployment_notifications_to_slack"></a> [send\_deployment\_notifications\_to\_slack](#input\_send\_deployment\_notifications\_to\_slack) | Do you want to send deployment notifications to Slack (true/false)? | `bool` | `false` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the App Runner service. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the App Runner resources. | `map(string)` | n/a | yes |
| <a name="input_use_custom_domain"></a> [use\_custom\_domain](#input\_use\_custom\_domain) | Use custom domain for your AppRunner service (true/false)? Note, that this will create DNS records you have to add to your DNS provider | `bool` | `false` | no |
| <a name="input_vpc_connector_arn"></a> [vpc\_connector\_arn](#input\_vpc\_connector\_arn) | The ARN of the VPC connector used to enable network access for the service. If left empty, the service will not be connected to a VPC. | `string` | `""` | no |
| <a name="input_waf_arn"></a> [waf\_arn](#input\_waf\_arn) | Web ACL ARN of WAF to associate | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_arn"></a> [service\_arn](#output\_service\_arn) | The Amazon Resource Name (ARN) of the App Runner service. |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | The unique identifier of the App Runner service. |
| <a name="output_service_status"></a> [service\_status](#output\_service\_status) | The current operational status of the App Runner service (e.g., RUNNING, FAILED, etc.). |
| <a name="output_service_url"></a> [service\_url](#output\_service\_url) | The publicly accessible URL of the App Runner service. |
