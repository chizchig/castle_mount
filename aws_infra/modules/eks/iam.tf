# modules/eks/iam.tf
resource "aws_iam_role" "eks_roles" {
  for_each = var.roles

  name = "${var.cluster_name}-${each.value.name}"  # Add cluster name prefix for uniqueness
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = each.key == "eks_role" ? "eks.amazonaws.com" : "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy_attachments" {
  for_each = merge([
    for role_name, role_data in var.roles : {
      for policy_arn in role_data.policy_arns :
      "${role_name}-${policy_arn}" => {
        role_name  = role_name
        policy_arn = policy_arn
      }
    }
  ]...)

  role       = aws_iam_role.eks_roles[each.value.role_name].name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_role" "node_role" {
  name = "${var.cluster_name}-worker-node-role"  # Add cluster name prefix

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "node_policy_policy_attachment" {
  role       = aws_iam_role.node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni_policy_policy_attachment" {
  role       = aws_iam_role.node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "registry_policy_policy_attachment" {
  role       = aws_iam_role.node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy" "node_additional_policy" {
  name = "${var.cluster_name}-node-additional-policy"
  role = aws_iam_role.node_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "eks:*",
          "ec2:CreateLaunchTemplate",
          "ec2:CreateFleet",
          "ec2:RunInstances",
          "ec2:DescribeInstances",
          "iam:CreateServiceLinkedRole",
          "iam:AttachRolePolicy",
          "iam:PutRolePolicy"
        ],
        Resource = "*"
      }
    ]
  })
}