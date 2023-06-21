resource "aws_eks_cluster" "aws_eks_cluster_tic" {
  name     = var.cluster_name
  version  = var.kubernetes_version
  role_arn = aws_iam_role.eks-iam-role.arn

  vpc_config {
    subnet_ids = aws_subnet.k8s-acc.*.id
  }

  tags = {
    app = var.project_name
  }

  depends_on = [
    aws_iam_role.eks-iam-role,
    aws_vpc.k8s-acc,
    aws_subnet.k8s-acc,
    aws_internet_gateway.k8s-acc,
    aws_route_table.k8s-acc,
    aws_route_table_association.k8s-acc
  ]
}
