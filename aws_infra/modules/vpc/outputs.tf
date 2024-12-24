output "vpc_id" {
  value = aws_vpc.network.id
}

output "public_subnet_ids" {
  value = { for k, v in aws_subnet.public : k => v.id }
}

output "private_subnet_ids" {
  value = { for k, v in aws_subnet.private : k => v.id }
}

output "database_subnet_ids" {
  value = { for k, v in aws_subnet.database : k => v.id }
}

# output "public_subnets" {
#   value = {
#     for subnet in aws_subnet.public :
#     subnet.id => subnet.id
#   }
# }

output "public_subnets" {
  value = [for subnet in aws_subnet.public : subnet.id]
}



