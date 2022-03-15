output "vpc_default_id" {
         value = data.aws_vpc.default_vpc.id
}
output "subnets_id" {
        value = data.aws_subnets.default_subnets.ids

}

output "all_avail_zones" {
        value = data.aws_availability_zones.available.names

}

output "subnet_cidr_blocks" {
         value = [for cidrs in data.aws_subnet.default : cidrs.cidr_block]
}

output "dev_security_groups" {
        value = data.aws_security_groups.dev.ids

}
