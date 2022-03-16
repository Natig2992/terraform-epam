################## Main config for initialize #######################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
  backend "s3" {
    bucket  = "mys3testagroimportant"
    key     = "epam-terraform/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }

  required_version = ">= 1.1.7"
}


provider "aws" {

  region = var.region
}

##################### Task-2 Data sources #############################

data "aws_availability_zones" "available" {}

data "aws_vpc" "default_vpc" {
  default = true

}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "template_file" "user_data" {
  template = file("./userdata.tpl")
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

##################### EC2 nginx-web-server #################################


resource "aws_security_group" "web_nginx_sg" {

  name   = "Dynamic Security Group for EPAM"
  vpc_id = data.aws_vpc.default_vpc.id
  dynamic "ingress" {

    for_each = ["80", "443", "22"]

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic sec group for EPAM"
    Owner = "Nagiev Natig"

  }
}


resource "aws_instance" "web_nginx" {

  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_1
  vpc_security_group_ids = [aws_security_group.web_nginx_sg.id]
  user_data              = data.template_file.user_data.rendered
  key_name               = var.key_name

  tags = {
    Name  = "EPAM-web-nginx"
    Owner = "Nagiev Natig"
  }

}
################### RDS Instance MySQL ###################################

resource "aws_security_group" "my_rds_epam_sg" {
  name        = "sg_for_my_epam_proj"
  description = "Allow MySQL inbound traffic"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress {
    description     = "RDS from EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_nginx_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [aws_security_group.web_nginx_sg]

  tags = {
    Name  = "Security group for EPAM rds"
    Owner = "Nagiev Natig"
  }
}

resource "aws_db_instance" "mysql_epam" {
  identifier                      = "mysql-epam"
  engine                          = "mysql"
  engine_version                  = "5.7.33"
  instance_class                  = "db.t2.micro"
  db_subnet_group_name            = aws_db_subnet_group.epam_db_sg.name
  enabled_cloudwatch_logs_exports = ["general", "error"]
  db_name                         = var.db_name
  username                        = var.db_username
  password                        = var.db_password
  allocated_storage               = 20
  max_allocated_storage           = 0
  backup_retention_period         = 7
  backup_window                   = "00:00-00:30"
  maintenance_window              = "Sun:17:30-Sun:18:30"
  storage_type                    = "gp2"
  vpc_security_group_ids          = [aws_security_group.my_rds_epam_sg.id]
  skip_final_snapshot             = true
  depends_on                      = [aws_security_group.my_rds_epam_sg, aws_db_subnet_group.epam_db_sg]
}

resource "aws_db_subnet_group" "epam_db_sg" {
  name       = "epam_db_subnet_group"
  subnet_ids = [var.subnet_1, var.subnet_2]
}

