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

variable "node_groups" {
  description = "Map of node groups with instance types, sizes, and scaling configurations."
  type = map(object({
    instance_type    = string
    desired_capacity = number
    min_size         = number
    max_size         = number
  }))
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
