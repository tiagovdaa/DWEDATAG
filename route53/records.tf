# route53/records.tf
resource "aws_route53_record" "ns_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "NS"
  ttl     = "172800"
  records = [
    "ns-1488.awsdns-58.org.",
    "ns-1777.awsdns-30.co.uk.",
    "ns-21.awsdns-02.com.",
    "ns-823.awsdns-38.net."
  ]
}

resource "aws_route53_record" "soa_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "SOA"
  ttl     = "900"
  records = [
    "ns-1777.awsdns-30.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
  ]
}