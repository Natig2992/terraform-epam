output "vpc_default_id" {
         value = data.aws_vpc.default_vpc.id
}

output "subnets_id" {
        value = data.aws_subnets.default_subnets.ids
}

output "availability_zones" {
        value = data.aws_availability_zones.available.names
}

output "public_nginx_ip" {
  value = "Web-server address: http://${aws_instance.web_nginx.public_dns}"
}

