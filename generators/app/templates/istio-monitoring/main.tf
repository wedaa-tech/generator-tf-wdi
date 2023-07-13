<%_ if( domain == "" ) { _%>

resource "kubectl_manifest" "create_namespace" {
    yaml_body = <<YAML
    apiVersion: v1
    kind: Namespace
    metadata:
      name: k8s
    YAML
}

locals {
  grafana-yamls = [for data in split("---", file("./resources/grafana.yaml")): yamldecode(data)]
}
resource "kubernetes_manifest" "grafana" {
  count = length(local.grafana-yamls)
  manifest = local.grafana-yamls[count.index]
  depends_on = [
    kubectl_manifest.create_namespace
  ]
}

locals {
  kiali-yamls = [for data in split("---", file("./resources/kiali.yaml")): yamldecode(data)]
}
resource "kubernetes_manifest" "kiali" {
  count = length(local.kiali-yamls)
  manifest = local.kiali-yamls[count.index]
  depends_on = [
    kubernetes_manifest.grafana
  ]
}

locals {
  prometheus-yamls = [for data in split("---", file("./resources/prometheus.yaml")): yamldecode(data)]
}
resource "kubernetes_manifest" "prometheus" {
  count = length(local.prometheus-yamls)
  manifest = local.prometheus-yamls[count.index]
  depends_on = [
    kubernetes_manifest.grafana,
    kubernetes_manifest.kiali
  ]
}
<%_ } else { _%>
module "eks_istio_monitoring" {
  source       = "github.com/coMakeIT-TIC/terraform_modules/k8s/istio_monitoring"
}
<%_ } _%>