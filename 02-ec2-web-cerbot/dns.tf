resource "aws_route53_record" "nlb_dns" {
  zone_id = var.zone_id
  name    = "webservernlb.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.web_nlb.dns_name
    zone_id                = aws_lb.web_nlb.zone_id
    evaluate_target_health = false
  }
}
