output "security_group_ids" {
  value = { for k, v in aws_security_group.this : k => v.id }
}


output "security_group_arns" {
  value = {
    for sg_name, sg in aws_security_group.this : sg_name => sg.arn
  }
  description = "Map of security group names to their corresponding ARNs"
}