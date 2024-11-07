resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.customer}-${var.project}-${var.environment}-DYNAMODB-STATE"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge({ Name = "${var.customer}-${var.project}-${var.environment}-DYNAMODB-STATE" }, local.tags)
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.s3_bucket_name

  tags = merge({ Name = "${var.customer}-${var.project}-${var.environment}-S3B-State" }, local.tags)
}

resource "aws_iam_user" "terraform_deployer" {
  name = "${var.customer}-${var.project}-${var.environment}-USER-IAM"
  path = var.iam_user_path
}

resource "aws_iam_user_policy_attachment" "admin_policy_attachment" {
  user       = aws_iam_user.terraform_deployer.name
  policy_arn = var.policy_arn
}


resource "aws_iam_access_key" "terraform_deployer_access_key" {
  user = aws_iam_user.terraform_deployer.name
}

output "project_1_admin_access_key" {
  value = aws_iam_access_key.terraform_deployer_access_key.id
  sensitive = true
}

output "project_1_admin_encrypted_secret_access_key" {
  value = aws_iam_access_key.terraform_deployer_access_key.secret
  sensitive = true
}

resource "local_file" "create_private_key" {
  content = aws_iam_access_key.terraform_deployer_access_key.secret
  filename = "${path.module}/aws_access_key" 
}
