locals {
  istio_charts_url = "https://istio-release.storage.googleapis.com/charts"
}

resource "helm_release" "istio-base" {
  repository       = local.istio_charts_url
  chart            = "base"
  name             = "istio-base"
  timeout          = 120
  namespace        = "istio-system"
  version          = "1.17.1"
  create_namespace = true
  cleanup_on_fail  = true
  force_update     = false
}

resource "helm_release" "istiod" {
  repository       = local.istio_charts_url
  chart            = "istiod"
  name             = "istiod"
  timeout          = 120
  namespace        = "istio-system"
  create_namespace = true
  version          = "1.17.1"
  cleanup_on_fail  = true
  force_update     = false
  depends_on       = [helm_release.istio-base]
}

resource "helm_release" "istio-ingressgateway" {
  repository      = local.istio_charts_url
  chart           = "gateway"
  name            = "istio-ingressgateway"
  cleanup_on_fail = true
  force_update    = false
  timeout         = 500
  namespace       = "istio-system"
  version         = "1.17.1"
  depends_on      = [helm_release.istiod]

  set {
    name = "name"
    value = "istio-ingressgateway"
  }
  set {
    name = "labels.app"
    value = "istio-ingressgateway"
  }
  set {
    name = "labels.istio"
    value = "ingressgateway"
  }
  # provision's application loadbalancer
  set {
    name  = "service.type"
    value = "NodePort"
  }
}

resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name = "ingress"
    namespace = "istio-system"
    labels = {
      app = "ingress"
    }
    annotations = {
      "kubernetes.io/ingress.class"       = "alb"
      "alb.ingress.kubernetes.io/scheme"  = "internet-facing"      
    }
  }

  spec {
    rule {
      http {
        path {
          backend {
            service {
              name = "istio-ingressgateway"
              port {
                number = 80
              }
            }
          }
          path = "/*"
        }
      }
    }
  }

  depends_on = [
    helm_release.istio-ingressgateway
  ]
}

# Adds default namespace as side car in istio 
resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "kubectl label namespace default istio-injection=enabled"
  }
  depends_on = [
    helm_release.istio-base,
    helm_release.istiod,
    helm_release.istio-ingressgateway
  ]
}