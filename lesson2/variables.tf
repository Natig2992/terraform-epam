variable "s3_name" {
  description = "S3 bucket name"
  type        = string
}

variable "region" {
  description = "My region for dev environment"
  type        = string
}

variable "instance_type" {
  description = "My dev instance type"
  type = string
}

variable "key_name" {
  description = "My SSH key name"
  type = string
}

variable "db_name" {
 description = "Databse name"
 type = string 
}

variable "db_username" {
 description = "Database username"
 type = string 
}

variable "db_password" {
  description = "Database password"
  type = string
  sensitive = true 
}

variable subnet_1 {
    description = "Default subnet 1"
    type = string
}


variable subnet_2 {
    description = "Default subnet 2"
    type = string
}
