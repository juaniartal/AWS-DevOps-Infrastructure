resource "aws_s3_bucket" "grafana_dashboards" {
  bucket = local.dashboards_bucket

  tags = merge({ Name = "${var.customer}-${var.project}-${var.environment}-S3B-GRAFANA" }, local.tags)
}

resource "aws_s3_object" "apache_dashboard" {
  bucket = aws_s3_bucket.grafana_dashboards.id

  key          = "apache.json"
  source       = "./dashboards/apache.json"
  content_type = "application/json"
}
