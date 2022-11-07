output "server_ip" {
  value = aws_lightsail_static_ip.cloudlog.ip_address
}

output "login_user" {
  value = aws_lightsail_instance.cloudlog.username
}

output "login_string" {
  value = "ssh -i lightsail.pub ${aws_lightsail_instance.cloudlog.username}@${aws_lightsail_static_ip.cloudlog.ip_address}"
}