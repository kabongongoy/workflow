resource "aws_acm_certificate" "workflow-cert" {
  domain_name       = "wazobia.com.au"
  validation_method = "DNS"
  subject_alternative_names = ["*.wazobia.com.au"]
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "workflow-cert"
  }
  
}
