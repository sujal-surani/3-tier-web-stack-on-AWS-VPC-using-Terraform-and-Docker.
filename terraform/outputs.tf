output "server_public_ip" {
  value = aws_instance.server.public_ip
  description = "Public ip of server"
}

output "alb_dns_name" {

  value       = aws_lb.app_alb.dns_name
  description = "The public URL of the Application Load Balancer"
}