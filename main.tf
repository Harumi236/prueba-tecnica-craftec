provider "aws" {
  region = "us-east-1" # Change as needed
}

# --------------------------
# VPC & Networking
# --------------------------
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# --------------------------
# Load Balancer
# --------------------------
resource "aws_lb" "app_lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_1.id]
}

# --------------------------
# Backend EC2 Instances
# --------------------------
resource "aws_instance" "backend" {
  ami           = "ami-0c55b159cbfafe1f0" # Example Amazon Linux AMI, change as needed
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private_1.id
  security_groups = [aws_security_group.backend_sg.id]
}

# --------------------------
# Relational Database (RDS)
# --------------------------
resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  engine              = "mysql"
  instance_class      = "db.t3.micro"
  db_name             = "appdb"
  username           = "admin"
  password           = "securepassword"
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private_1.id]
}

# --------------------------
# NoSQL Database (DynamoDB)
# --------------------------
resource "aws_dynamodb_table" "app_table" {
  name           = "app-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# --------------------------
# NAT Gateway for External Service Access
# --------------------------
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_1.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# --------------------------
# Security Groups
# --------------------------
resource "aws_security_group" "lb_sg" {
  vpc_id = aws_vpc.main.id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }
}

resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }
}
