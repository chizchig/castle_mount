output "public_subnets" {
  value = module.vpc.public_subnet_ids
}

# output "database_subnet_ids" {
#   value = module.vpc.database_subnets
# }

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "all_security_group_ids" {
  value = module.security_group.security_group_ids
}

output "all_security_group_arns" {
  value = module.security_group.security_group_arns
}

# You can access the outputs like this:
output "rds_endpoints" {
  value = module.rds.rds_endpoints
}

output "rds_instance_ids" {
  value = module.rds.rds_instance_ids
}

output "rds_instance_arns" {
  value = module.rds.rds_instance_arns
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "debug_security_group_ids" {
  value = module.security_group.security_group_ids
}

# outputs.tf
output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.cloud_index.repository_url
}

# Additional useful outputs you might want
output "ecr_repository_arn" {
  description = "The ARN of the ECR repository"
  value       = aws_ecr_repository.cloud_index.arn
}

output "ecr_repository_registry_id" {
  description = "The registry ID where the repository was created"
  value       = aws_ecr_repository.cloud_index.registry_id
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_ca_certificate" {
  value = module.eks.cluster_ca_certificate
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "image_tag" {
  description = "The tag for the Docker image"
  value       = "latest"  # Or another dynamic value if needed
}