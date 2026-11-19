# Terraform AWS EC2 Web Server

## Project Overview
This project demonstrates the deployment of a Linux EC2 web server on AWS using Terraform.

Terraform is used to automate the creation and configuration of AWS infrastructure.

## Technologies Used
- AWS
- Terraform
- Ubuntu
- Git & GitHub

## AWS Resources Created
- VPC
- Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Instance

## AWS Region
`us-west-2` (US West – Oregon)

## Project Structure
```text
terraform-ec2-web-server/
│
├── main.tf
├── .terraform.lock.hcl
├── .gitignore
└── README.md
```

## Prerequisites
- AWS account
- AWS CLI installed and configured
- Terraform installed
- Git installed

## Steps to Deploy

**1. Initialize Terraform**
```bash
terraform init
```

**2. Validate Configuration**
```bash
terraform validate
```

**3. Preview Infrastructure**
```bash
terraform plan
```

**4. Deploy Infrastructure**
```bash
terraform apply
```

Enter `yes` when prompted.

**5. View Public IP**
```bash
terraform output
```

Use the public IP address to access the deployed web server through a browser.

## Cleanup
To delete the AWS resources created by this project, run:

```bash
terraform destroy
```

Confirm with `yes` when prompted.

## Author
Kantamani Radhadevi
