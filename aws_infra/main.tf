data "aws_availability_zones" "available" {
  state = "available"
}


module "vpc" {
  source = "./modules/vpc"

  name             = var.name
  vpc_cidr_block   = var.vpc_cidr_block
  azs              = local.az_names
  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  database_subnets = local.database_subnets

  enable_nat_gateway = false
  enable_vpn_gateway = true

  tags = {
    Name = "${var.name}_vpc"
  }
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # VPC Configuration
  # vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  # private_subnets = module.vpc.private_subnets

  # Node groups configuration
  node_groups     = var.node_groups

  # IAM roles configuration
  roles           = var.roles

  # Tags
  # tags = {
  #   Environment = var.environment
  #   Project     = var.project_name
  # }
}

module "security_group" {
  source = "./modules/security_group"

  vpc_id          = module.vpc.vpc_id
  security_groups = var.security_groups
}

module "rds" {
  source = "./modules/rds"

  rds_instances = {
    for k, v in var.rds_instances : k => merge(v, {
      vpc_security_group_ids = values(module.security_group.security_group_ids)  # Use all security group IDs
      

    })
  }

  private_subnet_ids = values(module.vpc.private_subnet_ids)  # Convert map to list

  subnet_group = {
    name       = "${var.name}-db-subnet-group"
    subnet_ids = coalesce(var.subnet_group.subnet_ids, values(module.vpc.database_subnet_ids))
    tags       = {
      Name = "${var.name}-db-subnet-group"
    }
  }
}

data "aws_caller_identity" "current" {}

# Create an Amazon ECR repository
resource "aws_ecr_repository" "cloud_index" {
  name                 = var.ecr_repository_name
  image_tag_mutability = var.image_tag_mutability

  # Enable image scanning on push
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  # Encrypt the repository
  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.kms_key_arn
  }

  tags = merge(
    var.tags,
    {
      Name      = var.ecr_repository_name
      ManagedBy = "Terraform"
      AccountID = data.aws_caller_identity.current.account_id
    }
  )
}

# Create a lifecycle policy for the ECR repository
resource "aws_ecr_lifecycle_policy" "cloud_index" {
  repository = aws_ecr_repository.cloud_index.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images older than ${var.untagged_image_expiration_days} days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = var.untagged_image_expiration_days
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "null_resource" "k8s_deploy" {
  depends_on = [module.eks]

  provisioner "local-exec" {
  command = <<EOT
    aws eks update-kubeconfig --name falcon-eks-cluster --region us-east-1 &&
    kubectl apply -f ./k8s/deployment.yml &&
    kubectl apply -f ./k8s/service.yml &&
    kubectl apply -f ./k8s/ingress.yml
  EOT
 }

}

# resource "helm_release" "aws_load_balancer_controller" {
#   name       = "aws-load-balancer-controller"
#   repository = "https://aws.github.io/eks-charts"
#   chart      = "aws-load-balancer-controller"
#   namespace  = "kube-system"

#   set {
#     name  = "clusterName"
#     value = var.cluster_name
#   }

#   set {
#     name  = "serviceAccount.create"
#     value = "true"
#   }

#   # set {
#   #   name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#   #   value = aws_iam_role.lb_controller.arn
#   # }
# }