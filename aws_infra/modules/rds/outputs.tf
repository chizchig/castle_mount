output "rds_endpoints" {
  description = "The endpoints of the RDS instances"
  value       = { for rds in aws_db_instance.rds_instance : rds.id => rds.endpoint }
}

output "rds_instance_ids" {
  description = "The IDs of the RDS instances"
  value       = { for rds in aws_db_instance.rds_instance : rds.id => rds.id }
}

output "rds_instance_arns" {
  description = "The ARNs of the RDS instances"
  value       = { for rds in aws_db_instance.rds_instance : rds.id => rds.arn }
}
