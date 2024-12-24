name           = "eagle"
vpc_cidr_block = "192.168.0.0/16"
azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
node_groups = {
  "node-group-1" = {
    instance_type    = "t3.medium"
    desired_capacity = 2
    max_size     = 3
    min_size     = 1
  },
  "node-group-2" = {
    instance_type    = "t3.large"
    desired_capacity = 3
    max_size     = 4
    min_size     = 2
  }
}

public_subnets = {
  "subnet1" = {
    cidr = "10.0.1.0/24"
    az   = "us-west-2a"
  }
  "subnet2" = {
    cidr = "10.0.2.0/24"
    az   = "us-west-2b"
  }
}

roles = {
  eks_role = {
    name = "eks-cluster-role"
    policy_arns = [
      "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
      "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    ]
  },
  node_role = {
    name = "eks-node-role"
    policy_arns = [
      "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
      "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
      "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    ]
  }
}

# Security Groups Configuration
security_groups = {
  "web-sg" = {
    name        = "web-sg"
    description = "Security group for web servers"
    ingress_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    tags = {
      Name = "web-sg"
    }
  }
  
  "db-sg" = {
    name        = "db-sg"
    description = "Security group for database servers"
    ingress_rules = [
      {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    tags = {
      Name = "db-sg"
    }
  }
}

rds_instances = {
  "instance1" = {
    identifier           = "massage-website-db"
    allocated_storage    = 20
    storage_type         = "standard"
    engine               = "mysql"
    engine_version       = "8.0.39"
    instance_class       = "db.t3.micro"
    db_name              = "mydb"
    username             = "admin"
    password             = "password123"  # Use secure password management in production
    parameter_group_name = "default.mysql8.0"
    subnet_group_name    = "main"  # This should match the key in subnet_groups
    skip_final_snapshot  = true
    publicly_accessible  = false
    multi_az             = false
    vpc_security_group_ids = []  # This will be overwritten in the module call
    tags                 = {
      Environment = "dev"
    }
  }
  # Add more instances as needed

}

subnet_group = {
  name       = "my-db-subnet-group"
  subnet_ids = null  # Set to null to use the VPC module's output
  tags       = {
    Name        = "my-db-subnet-group"
    Environment = "production"
  }
}

 ecr_repository_name = "eagle_ecr"