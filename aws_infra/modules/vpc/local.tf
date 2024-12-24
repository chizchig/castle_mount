locals {
  az_names = slice(data.aws_availability_zones.available.names, 0, 3)

  public_subnets = {
    for i, az in local.az_names : "public${i + 1}" => {
      cidr = cidrsubnet(var.vpc_cidr_block, 8, i)
      az   = az
    }
  }

  private_subnets = {
    for i, az in local.az_names : "private${i + 1}" => {
      cidr = cidrsubnet(var.vpc_cidr_block, 8, i + length(local.az_names))
      az   = az
    }
  }

  database_subnets = {
    for i, az in local.az_names : "database${i + 1}" => {
      cidr = cidrsubnet(var.vpc_cidr_block, 8, i + 2 * length(local.az_names))
      az   = az
    }
  }
}
