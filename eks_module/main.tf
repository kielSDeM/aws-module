resource "aws_eks_cluster" "eks_east" {
  name     = "eks_east"
  role_arn = aws_iam_role.iam-eks-cluster.arn

  vpc_config {
    subnet_ids             = var.priv_sub
    vpc_security_group_ids = [var.sec_group]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.EksEast-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_node_group" "node_east1" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "node_east1"
  node_role_arn   = aws_iam_role.example.arn
  subnet_ids      = var.priv_sub

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1

    instance_type = "t2.small"
  }

  update_config {
    max_unavailable = 2
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}
