data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "cluster" {
  name = "${var.cluster_name}"
}

module "eks_cluster_autoscaler" {
  source  = "github.com/wedaa-tech/terraform-aws-eks-cluster-autoscaler"

  cluster_name = var.cluster_name
  cluster_identity_oidc_issuer = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  cluster_identity_oidc_issuer_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")}"
}

module "ebs_csi_driver" {
  source       = "github.com/wedaa-tech/terraform-aws-eks-ebs-csi-driver"

  cluster_name = var.cluster_name
  region       = var.region
}

module "aws_lb_controller" {
  source       = "github.com/wedaa-tech/terraform-aws-eks-lb-controller"
  
  cluster_name = var.cluster_name
  region       = var.region
}
