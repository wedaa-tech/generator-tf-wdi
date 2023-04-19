module "ebs_csi_driver" {
  source       = "github.com/coMakeIT-TIC/terraform_modules/aws/ebs_csi_driver"
  cluster-name = var.cluster_name
  region       = var.region

}
