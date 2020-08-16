output "alb_dns_name" {
  value       = aws_lb.public_alb.dns_name
  description = ""
}

output "domain_name" {
  value       = aws_route53_record.root.name
  description = ""
}

output "target_group_blue_arn" {
  value = aws_lb_target_group.blue.arn
  description = ""
}

output "target_group_green_arn" {
  value = aws_lb_target_group.green.arn
  description = ""
}
