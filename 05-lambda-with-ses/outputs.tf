output "lambda_function_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.send_email_function.arn
}

output "ses_email_identity" {
  description = "SES Email Identity"
  value       = aws_ses_email_identity.sender_email.email
}
