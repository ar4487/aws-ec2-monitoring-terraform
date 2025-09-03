# 🚀 AWS EC2 Monitoring with Terraform

[![Terraform](https://img.shields.io/badge/Terraform-v1.2+-blueviolet?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EC2%20|%20CloudWatch%20|%20SNS-orange?logo=amazon-aws)](https://aws.amazon.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![GitHub](https://img.shields.io/badge/GitHub-Repo-black?logo=github)](https://github.com/your-username/aws-ec2-monitoring-terraform)


## 📌 Project Overview
This project provisions an **AWS EC2 instance** with the following:

- Attached **EBS volume**  
- Configured **Security Group** and **IAM role**  
- **CloudWatch Alarm** to monitor CPU utilization  
- **SNS Topic** with email subscription for alerts  

The entire setup is managed via **Terraform** following Infrastructure as Code (IaC) principles.  
This project demonstrates **DevOps / SRE skills** in automating infrastructure, monitoring, and alerting.

---

---

## ⚙️ Tech Stack
- **Terraform** (v1.2+)  
- **AWS** (EC2, EBS, CloudWatch, SNS, IAM, Security Groups)  
- **Linux** (stress test for CPU load)  
- **GitHub** (version control + portfolio)  

---

## 📂 Project Structure
```
aws-ec2-monitoring-terraform/
│── diagrams/
│   └── architecture.png   # architecture diagram
│── main.tf                # EC2, EBS, CloudWatch, SNS resources
│── provider.tf            # provider + terraform block
│── variables.tf           # input variables
│── terraform.tfvars       # values for variables (excluded from git)
│── outputs.tf             # outputs like IPs, IDs, ARNs
│── .gitignore             # ignore state, credentials
│── README.md              # project documentation
```

---

## 🚀 How to Deploy

### 1️⃣ Clone Repo
```bash
git clone https://github.com/ar4487/aws-ec2-monitoring-terraform.git
cd aws-ec2-monitoring-terraform
```

### 2️⃣ Initialize Terraform
```bash
terraform init
```

### 3️⃣ Update Variables
Edit **terraform.tfvars**:
```hcl
aws_region    = "us-east-1"
ami_id        = "ami-xxxxxxxx"
instance_type = "t2.micro"
alarm_email   = "your-email@example.com"
```

### 4️⃣ Apply Configuration
```bash
terraform apply -auto-approve
```

### 5️⃣ Confirm Email Subscription
- Check your inbox for an email from **AWS SNS**  
- Confirm subscription → you’ll start receiving alerts  

### 6️⃣ Stress Test EC2
SSH into the instance and run:
```bash
sudo yum install stress -y   # Amazon Linux
stress --cpu 2 --timeout 180
```
This will push CPU > 70% and trigger the alarm.

---

## 📊 Outputs

After deployment, run:
```bash
terraform output
```

**Example:**
```
ec2_public_ip        = "54.210.xxx.xxx"
ec2_instance_id      = "i-0abcdef1234567890"
ebs_volume_id        = "vol-0123456789abcdef0"
cloudwatch_alarm_arn = "arn:aws:cloudwatch:..."
sns_topic_arn        = "arn:aws:sns:..."
```

---

## 🛑 Cleanup
To avoid charges:
```bash
terraform destroy -auto-approve
```

---

## 🎯 What I Learned
- Building reusable Terraform templates  
- Creating AWS infrastructure with IaC  
- Setting up monitoring + alerting using CloudWatch + SNS  
- Using stress testing to validate alerts  
- Securing Terraform projects with `.gitignore`  

---

## 👨‍💻 Author
**Arpit Bhadoria**  
[LinkedIn Profile](https://www.linkedin.com/in/arpit-bhadoria-8a883b232)
