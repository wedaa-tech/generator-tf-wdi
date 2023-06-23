resource "helm_release" "nginx-ingress-controller" {
  name            = "nginx-ingress-controller"
  repository      = "https://kubernetes.github.io/ingress-nginx/"
  chart           = "ingress-nginx"
  timeout         = 120
  cleanup_on_fail = true
  force_update    = false
}
