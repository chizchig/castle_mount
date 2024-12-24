
variable "name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "azs" {
  type = list(string)
}



variable "enable_nat_gateway" {
  type    = bool
  default = false
}

variable "enable_vpn_gateway" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "node_groups" {
  description = "Map of node groups with instance types, sizes, and scaling configurations."
  type = map(object({
    instance_type    = string
    desired_capacity = number
    min_size         = number
    max_size         = number
  }))
}

variable "cluster_name" {
  type    = string
  default = "eagle-eks-cluster"
}

variable "cluster_version" {
  type    = string
  default = "1.31"
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "roles" {
  type = map(object({
    name        = string
    policy_arns = list(string)
  }))
}

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



variable "rds_instances" {
  description = "A map of RDS instance configurations"
  type = map(object({
    identifier             = string
    allocated_storage      = number
    storage_type           = string
    engine                 = string
    engine_version         = string
    instance_class         = string
    db_name                = string
    username               = string
    password               = string
    parameter_group_name   = string
    skip_final_snapshot    = bool
    publicly_accessible    = bool
    multi_az               = bool
    vpc_security_group_ids = list(string)
    tags                   = map(string)
  }))
}

variable "subnet_group" {
  description = "Configuration for the DB subnet group"
  type = object({
    name       = string
    subnet_ids = list(string)
    tags       = map(string)
  })
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs from the VPC module"
  type        = list(string)
  default     = []
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE."
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)"
  type        = bool
  default     = true
}

variable "untagged_image_expiration_days" {
  description = "Number of days before an untagged image expires"
  type        = number
  default     = 30
}


variable "encryption_type" {
  description = "The encryption type to use for the repository. Valid values are AES256 or KMS"
  type        = string
  default     = "AES256"
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use when encryption_type is KMS. If not specified, uses the default AWS managed key for ECR"
  type        = string
  default     = null
}