resource "aws_iam_role" "lambda_role" {
  name = "lambda_with_ses_and_cloudwatch"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_ses_policy" {
  name = "lambda_ses_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ses:VerifyEmailIdentity",
          "ses:VerifyEmailAddress",
          "ses:TestRenderTemplate",
          "ses:SendEmail",
          "ses:SendRawEmail"
        ],
        Resource = "*"
      }
    ]
  })
  depends_on = [
    aws_iam_role.lambda_role  
  ]
}

resource "aws_iam_policy" "lambda_logs_policy" {
  name = "lambda_logs_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:DescribeLogStreams",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
  depends_on = [
    aws_iam_role.lambda_role  
  ]
}

resource "aws_iam_role_policy_attachment" "attach_ses_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_ses_policy.arn
  depends_on = [
    aws_iam_role.lambda_role,
    aws_iam_policy.lambda_ses_policy  
  ]
}

resource "aws_iam_role_policy_attachment" "attach_logs_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_logs_policy.arn

  depends_on = [
    aws_iam_role.lambda_role,
    aws_iam_policy.lambda_logs_policy  
  ]
}