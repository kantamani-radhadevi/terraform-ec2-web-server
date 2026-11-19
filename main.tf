
provider "aws" {
  region = "ap-south-1"
}

# 1. Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Task1-VPC"
  }
}

# 2. Create Public Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Task1-Subnet"
  }
}

# 3. Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Task1-IGW"
  }
}

# 4. Create Route Table
resource "aws_route_table" "my_route" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "Task1-Route"
  }
}

resource "aws_route_table_association" "my_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route.id
}

# 5. Create Security Group
resource "aws_security_group" "my_sg" {
  name   = "Task1-Security-Group"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 6. Find Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 7. Create EC2 Instance
resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.my_subnet.id
  vpc_security_group_ids      = [aws_security_group.my_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>My First Terraform Web Server!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Task1-Web-Server"
  }
}

# 8. Display Public IP
output "public_ip" {
  value = aws_instance.web_server.public_ip
}
