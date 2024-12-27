output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}
output "cluster_ca_certificate" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
  description = "CA certificate for your Kubernetes cluster"
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
  description = "ID of the EKS cluster"
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