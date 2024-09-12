output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.deploy-server.public_ip
}
