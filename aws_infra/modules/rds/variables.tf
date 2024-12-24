variable "rds_instances" {
  description = "A map of RDS instance configurations"
  type = map(object({
    identifier             = string
    db_name                = string
    allocated_storage      = number
    storage_type           = string
    engine                 = string
    engine_version         = string
    instance_class         = string
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
}
