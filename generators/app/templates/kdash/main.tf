module "kdash" {
  source  = "wedaa-tech/kdash/k8s"
  dashboard_cluster_name = var.dashboard_cluster_name
}