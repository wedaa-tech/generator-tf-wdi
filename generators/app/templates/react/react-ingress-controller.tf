resource "kubernetes_ingress_v1" "ingress" {
  wait_for_load_balancer = true
  metadata {
    name      = "react-ingress-nginx"
    namespace = var.namespace
  }

  spec {
    ingress_class_name = "nginx"
    rule {
      host = <%- "\""+domain+"\""%>
      http {
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service.react-service.metadata.0.name
              port {
                number = var.port
              }
            }
          }
        }
      }
    }
  }
}
