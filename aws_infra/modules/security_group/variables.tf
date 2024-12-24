variable "security_groups" {
  description = "A map of security group configurations"
  type = map(object({
    name          = string
    description   = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress_rules  = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    tags          = map(string)
  }))
}

variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs from the VPC module"
  type        = list(string)
  default     = []
}