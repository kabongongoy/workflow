resource "aws_acm_certificate" "workflow-cert" {
  domain_name       = "wazobia.com.au"
  validation_method = "DNS"
  subject_alternative_names = ["www.wazobia.com.au"]
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "workflow-cert"
  }
  
}

data "aws_route53_zone" "primary" {
  name         = "wazobia.com.au."
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.workflow-cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.primary.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.workflow-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
