# output "public_ip" {
#   value       = aws_instance.web-server.public_ip
#   description = "The public ip address of the created instance"

# }

output "alb_dns_name" {
  value = aws_alb.nginx-alb.dns_name
  description = "The DNS name of the created ALB"
}