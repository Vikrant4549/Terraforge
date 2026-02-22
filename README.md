# TerraForge 🚀

TerraForge is a production-style infrastructure project that provisions a Dockerized Node.js application on AWS using Terraform.

This project demonstrates Infrastructure as Code (IaC), containerization, and cloud deployment best practices.

## IMPORTANT NOTE
EC2 pulls image from private ECR. Before running Terraform, build and push Docker image to your own ECR repository.

---

## 🏗 Architecture Overview

- Custom VPC
- Public Subnet
- Internet Gateway
- Route Table & Association
- Security Group
- IAM Role with ECR access
- EC2 Instance
- Docker
- Private Amazon ECR Repository

Application flow:

Internet → Internet Gateway → Public Subnet → EC2 → Docker → Private ECR Image → Node.js App

---

## 🧰 Tech Stack

- **AWS**
  - EC2
  - VPC
  - IAM
  - ECR (Private)
- **Terraform**
- **Docker**
- **Node.js (Express)**

---

## 🚀 Features

- Infrastructure fully provisioned using Terraform
- Dockerized application pulled from private ECR
- IAM role-based authentication (no hardcoded credentials)
- Custom VPC networking setup
- Public HTTP access via EC2

---

## 📦 Deployment Steps

1. Clone repository

2. Navigate to terraform directory: 
cd terraform

3. Initialize Terraform: 
terraform init

4. Review execution plan:
terraform plan

5. Apply infrastructure:
terraform apply

6. Access application via EC2 public IP
http://<ec2 ip>

## 🔐 Security Notes

- No hardcoded AWS credentials
- EC2 uses IAM Role with least privilege (ECR read-only)
- Terraform state files excluded via .gitignore

---

## 📌 Future Improvements

- Add Application Load Balancer
- Enable HTTPS with ACM
- Implement Auto Scaling Group
- Add CI/CD pipeline with GitHub Actions
- Add Route53 custom domain

---

## 👨‍💻 Author

Vikrant Rathod  
