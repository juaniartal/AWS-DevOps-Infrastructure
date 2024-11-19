resource "aws_route53_record" "web_server_dns" {
  zone_id = var.zone_id
  name    = "webserverjuan4.${var.domain_name}"
  type    = "A"
  ttl     = var.ttl
  records = [aws_instance.web_server.public_ip]
}



