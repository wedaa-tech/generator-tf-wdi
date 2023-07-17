resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${var.cluster_name}"
  }
  depends_on = [
    aws_eks_cluster.aws_eks_cluster_tic,
  <%_ if(enableECK) { _%>
    aws_eks_node_group.eck-node-group,
  <%_ } _%>
    aws_eks_node_group.apps-node-group
  ]
}
