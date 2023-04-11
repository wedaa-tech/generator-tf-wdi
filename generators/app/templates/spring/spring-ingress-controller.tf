<%if(cloudProvider == "aws") {%>
resource "kubernetes_ingress_v1" "ingress" {
  wait_for_load_balancer = true
  metadata {
    namespace = var.namespace
    name = "spring-ingress-nginx"
  }

  spec {
    ingress_class_name = "nginx"
    rule {
      host = <%- "\"be."+domain+"\""%>
      http {
        path {
          path = "/"
          backend {
            service {
              name = "demo-app-spring"
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
<% }%>