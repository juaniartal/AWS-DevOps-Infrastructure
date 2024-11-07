############################## CERTIFICADO ##################################
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = var.subject_alternative_names

  tags = merge(
    { Name = "${local.app_name_dashed}-Web-cert" },
    var.tags
  )
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      record  = dvo.resource_record_value
      zone_id = var.zone_id
    }
  }

  zone_id = each.value.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = var.ttl
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]

  timeouts {
    create = var.timeout
  }
}

############################## RECORDS ##################################


resource "aws_route53_record" "webserver1" {
  zone_id = var.zone_id
  name    = "webserver1.${var.domain_name}"
  type    = "A"
  ttl     = var.ttl
  records = [aws_eip.eip_web_server_a.public_ip]
}

resource "aws_route53_record" "webserver2" {
  zone_id = var.zone_id
  name    = "webserver2.${var.domain_name}"
  type    = "A"
  ttl     = var.ttl
  records = [aws_eip.eip_web_server_b.public_ip]
}

resource "aws_route53_record" "webserver_alias" {
  zone_id = var.zone_id
  name    = "webserver.${var.domain_name}"
  type    = "CNAME"
  ttl     = var.ttl
  records = [aws_lb.web_lb.dns_name]
}