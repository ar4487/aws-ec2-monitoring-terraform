variable "aws_region" {
    description = "AWS region to deploy  resource"
    type = string
    default = "us-east-1"
}

variable "instance_type" {
    description = "EC2 instance type "
    type = string

}
variable "ec2_key_pair" {
    description = "key to connect instance"
    type = string
}

variable "volume_size" {
    description ="size of EBS volume"
    type = number 
    default =8
}

variable "alarm_email" {
    description = "Email Address for cloudwatch SNS alert"
    type = string
}
