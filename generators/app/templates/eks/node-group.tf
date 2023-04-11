resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = aws_eks_cluster.aws_eks_cluster_tic.name
  node_group_name = "terraform-k8s-workernodes"
  node_role_arn   = aws_iam_role.workernodes.arn
  subnet_ids      = aws_subnet.k8s-acc.*.id
  instance_types  = ["t3.medium"]

  scaling_config {
    max_size     = 3
    desired_size = 1
    min_size     = 1
  }

   tags = {
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"   = "true"
  }

  depends_on = [
    aws_eks_cluster.aws_eks_cluster_tic,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
