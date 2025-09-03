# Public IP of EC2 Instance
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}

# Instance ID
output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2.id
}

# EBS Volume ID
output "ebs_volume_id" {
  description = "ID of the attached EBS volume"
  value       = aws_ebs_volume.extra_volume.id
}

# CloudWatch Alarm ARN
output "cloudwatch_alarm_arn" {
  description = "ARN of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.high_cpu.arn
}

# SNS Topic ARN
output "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  value       = aws_sns_topic.alarm_topic.arn
}
