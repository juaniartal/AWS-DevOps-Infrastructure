resource "aws_iam_role" "ec2_ssm_role" {
  name = "SSM-EC2-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Adjuntar política de SSM
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Adjuntar política completa para S3 (permiso total)
resource "aws_iam_role_policy" "s3_full_access_policy" {
  role = aws_iam_role.ec2_ssm_role.name
  name = "EC2-S3-Full-Access-Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:*" # Permite todas las acciones de S3
        Resource = [
          "arn:aws:s3:::dashboards-grafana-academy-box-1",  # Permiso para el bucket
          "arn:aws:s3:::dashboards-grafana-academy-box-1/*" # Permiso para los objetos dentro del bucket
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_ssm_instance_profile" {
  name = "SSM-EC2-Instance-Profile"
  role = aws_iam_role.ec2_ssm_role.name
}