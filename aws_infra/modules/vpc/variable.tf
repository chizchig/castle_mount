variable "name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "database_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
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

# variable "vpc_id" {
#   description = "The ID of the VPC where the security groups will be created"
#   type        = string
# }

