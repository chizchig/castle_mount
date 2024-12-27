# modules/eks/main.tf
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

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = var.public_subnets

  scaling_config {
    desired_size = lookup(var.node_groups.main, "desired_size", 2)
    max_size     = lookup(var.node_groups.main, "max_size", 3)
    min_size     = lookup(var.node_groups.main, "min_size", 1)
  }

  instance_types = ["t3.medium"]

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_iam_role_policy_attachment.node_policy_policy_attachment,
    aws_iam_role_policy_attachment.cni_policy_policy_attachment,
    aws_iam_role_policy_attachment.registry_policy_policy_attachment
  ]
}