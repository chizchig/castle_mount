# Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks_roles["eks_role"].arn

  vpc_config {
    subnet_ids             = var.public_subnets
    endpoint_public_access = true
    endpoint_private_access = false
  }

  depends_on = [aws_iam_role_policy_attachment.eks_policy_attachments]
}