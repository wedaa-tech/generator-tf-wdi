resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${var.cluster_name}"
  }
  depends_on = [
    aws_eks_cluster.aws_eks_cluster_tic,
    aws_eks_node_group.worker-node-group
  ]
}
