variable "cluster_name" {
  type    = string
  default = "falcon-eks-cluster"
}

variable "cluster_version" {
  type    = string
  default = "1.28"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet IDs"
}

# modules/eks/variables.tf
variable "node_groups" {
  type = map(object({
    desired_size = number
    max_size     = number
    min_size     = number
  }))
  default = {
    main = {
      desired_size = 2
      max_size     = 3
      min_size     = 1
    }
  }
}

# variable "roles" {
#   type = map(object({
#     name     = string
#     policies = list(string)
#   }))
#   default = {
#     eks_role = {
#       name     = "eks-role"
#       policies = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
#     }
#     node_role = {
#       name     = "node-role"
#       policies = [
#         "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
#         "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
#         "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#       ]
#     }
#   }
# }

variable "roles" {
  type = map(object({
    name        = string
    policy_arns = list(string)
  }))
}
