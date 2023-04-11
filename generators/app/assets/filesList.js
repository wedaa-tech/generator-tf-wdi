const fileListAws = [
  "auto-deploy.sh",
  "install.sh",
  "destroy.sh",
  "terraform-install.sh",
  "README.md",
  "eks/cluster.tf",
  "eks/IAMrole-eks.tf",
  "eks/IAMrole-worker.tf",
  "eks/kubeconfig.tf",
  "eks/identity-provider.tf",
  "eks/node-group.tf",
  "eks/provider.tf",
  "eks/variables.tf",
  "eks/vpc.tf",
  "eks/autoscaling-group.tf",
  "eks/check-infra.tf",
  "eks/data-source.tf"
];

const fileListECR = ["ecr/ecr.tf", "ecr/provider.tf", "ecr/variables.tf"];

const fileListEcrBuildAndPush = [
  "ecr-build&publish/build-image.tf",
  "ecr-build&publish/provider.tf",
  "ecr-build&publish/publish-image.tf",
  "ecr-build&publish/README.md",
  "ecr-build&publish/variables.tf"
];

const fileListEBS = [
  "ebs/ebs_csi_driver.tf",
  "ebs/provider.tf",
  "ebs/variables.tf"
];

const fileListHelmNginx = ["helm/istio.tf", "helm/provider.tf"];

const fileListNamespace = ["namespace/namespace.tf", "namespace/provider.tf"];

const fileListMonitoring = [
  "monitoring/grafana.yaml",
  "monitoring/kiali.yaml",
  "monitoring/monitoring.tf",
  "monitoring/prometheus.yaml",
  "monitoring/provider.tf",
  "monitoring/README.md",
  "monitoring/variables.tf"
];

const fileListEksWebUI = ["eks-web-ui/provider.tf", "eks-web-ui/web-ui.tf"];

// Below files are not required for M1

// ? Need to add

const fileListAzure = [
  "aks/aks-cluster",
  "aks/kubernetes-config",
  "aks/outputs.tf",
  "aks/variables.tf",
  "aks/main.tf"
];

const fileListGcp = [
  "gke/gke-cluster",
  "gke/kubernetes-config",
  "gke/outputs.tf",
  "gke/variables.tf",
  "gke/main.tf"
];

module.exports = {
  fileListAws,
  fileListGcp,
  fileListAzure,
  fileListHelmNginx,
  fileListNamespace,
  fileListEBS,
  fileListECR,
  fileListEcrBuildAndPush,
  fileListMonitoring,
  fileListEksWebUI
};
