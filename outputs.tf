output "service_arn" {
  value       = aws_apprunner_service.this.arn
  description = "The Amazon Resource Name (ARN) of the App Runner service."
}

output "service_id" {
  value       = aws_apprunner_service.this.service_id
  description = "The unique identifier of the App Runner service."
}

output "service_url" {
  value       = "https://${aws_apprunner_service.this.service_url}"
  description = "The publicly accessible URL of the App Runner service."
}

output "service_fqdn" {
  value       = aws_apprunner_service.this.service_url
  description = "The FQDN of the App Runner service."
}

output "service_status" {
  value       = aws_apprunner_service.this.status
  description = "The current operational status of the App Runner service (e.g., RUNNING, FAILED, etc.)."
}
