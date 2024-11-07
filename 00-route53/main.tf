data "aws_caller_identity" "account-east" {
  provider = aws
}

resource "aws_route53_zone" "main" {
  name = "academybox1.academy.kopiustech.com"
  tags = merge({ Name = "${local.app_name_dashed}-ROUTE53-ZONE-MAIN" })
}


resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dev.academybox1.academy.kopiustech.com"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.main.name_servers
}
