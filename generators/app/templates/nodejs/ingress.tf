resource "kubernetes_ingress_v1" "ingress" {
  wait_for_load_balancer = true
  metadata {
    name      = "nodejs-ingress-nginx"
    namespace = var.namespace
  }

  spec {
    ingress_class_name = "nginx"
    rule {
      host = <%- "node.\""+domain+"\""%>
      http {
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service.nodejs-service.metadata.0.name
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
