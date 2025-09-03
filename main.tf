data "aws_vpc" "default" {
    default = true
}

#security Group for EC2
resource "aws_security_group" "ec2_sg" {
    name = "ec2-sg"
    description = "allow SSH and HTTP access"
    vpc_id = data.aws_vpc.default.id

    ingress {
        from_port = 22
        to_port =22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}


resource "aws_iam_instance_profile" "ec2_profile" {
    name = "ec2_instance_profile"
    role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "ec2" {
  ami                    = "ami-0360c520857e3138f" # Amazon Linux 2 (us-east-1)
  instance_type          = var.instance_type
  key_name               = var.ec2_key_pair
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "Terraform-EC2"
  }
}

resource "aws_ebs_volume" "extra_volume" {
    availability_zone = aws_instance.ec2.availability_zone
    size = var.volume_size
    tags ={
        Name = "Extra-volume"
    }
}

resource "aws_volume_attachment" "attach_volume" {
    device_name  = "/dev/sdh"
    volume_id = aws_ebs_volume.extra_volume.id
    instance_id = aws_instance.ec2.id
}

resource "aws_sns_topic" "alarm_topic" {
    name = "ec2-alaram-topic"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
    alarm_name = "high-cpu-ec2"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 1
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 60
    statistic = "Average"
    threshold = 20
    alarm_description = "this metric montiors EC2 CPU usage"
    alarm_actions       = [aws_sns_topic.alarm_topic.arn]

    dimensions = {
    InstanceId = aws_instance.ec2.id
  }
}