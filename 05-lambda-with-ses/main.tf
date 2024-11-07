data "archive_file" "lambda_code_archive" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"  # dpmde esta la carpeta
  output_path = "${path.module}/files/lambda_function_payload.zip"  # zip
}

resource "aws_lambda_function" "send_email_function" {
  filename      = "${path.module}/files/lambda_function_payload.zip"  
  function_name = "send_daily_email"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  environment {
    variables = {
      EMAIL_SUBJECT = "SOLICITUD DE MONITOR"
      EMAIL_BODY    = "Quiero 1 monitor test."
      EMAIL_TO      = var.email_to  
      EMAIL_FROM    = var.email_from  
    }
  }

depends_on = [
    aws_iam_role.lambda_role,
    aws_iam_role_policy_attachment.attach_ses_policy,
    aws_iam_role_policy_attachment.attach_logs_policy,
    data.archive_file.lambda_code_archive  
  ]
}

# cloudWatch logs Group
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/send_daily_email"
  retention_in_days = 14

depends_on = [
    aws_lambda_function.send_email_function  
  ]
}

# config de SES
resource "aws_ses_email_identity" "sender_email" {
  email = var.email_from  
}
resource "aws_ses_email_identity" "receptor_email" {
  email = var.email_to  
}


resource "aws_cloudwatch_event_rule" "daily_trigger" {
  name                = "lambda_trigger_every_2_minutes"
  schedule_expression = "rate(2 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.daily_trigger.name
  target_id = "send_daily_email"
  arn       = aws_lambda_function.send_email_function.arn

depends_on = [
    aws_cloudwatch_event_rule.daily_trigger,  
    aws_lambda_function.send_email_function 
  ]
}

resource "aws_lambda_permission" "allow_cloudwatch_to_invoke" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.send_email_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_trigger.arn

  depends_on = [
    aws_cloudwatch_event_rule.daily_trigger,  
    aws_lambda_function.send_email_function  
  ]
}
