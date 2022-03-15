################## Main config for initialize #######################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
 required_version = ">= 1.1.7"
}


provider "aws" {

  region = "eu-central-1"
}

###############Data sources for task-1 #############################

data "aws_availability_zones" "available" {}

data "aws_vpc" "default_vpc" {
  default = true

}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

data "aws_subnet" "default" {
  for_each = toset(data.aws_subnets.default_subnets.ids)
  id       = each.value
}

data "aws_security_groups" "dev" {
  tags = {
    Environment = "dev"
  }
}
