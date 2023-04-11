resource "kubernetes_service" "demo_app_spring_service" {
  metadata {
    name      = "demo-app-spring"
    namespace = var.namespace
    labels = {
      app = "demo-app-spring"
    }
  }

  spec {
    selector = {
      app = "demo-app-spring"
    }
    <%if(cloudProvider == "minikube") {%>
    type = "NodePort"
    port {
      name        = "http"
      protocol    = "TCP"
      port        = var.port
      target_port = var.port
      node_port   = 30010
    }
    <% } else if (cloudProvider == "aws") { %>
    type = "ClusterIP"
    port {
      name        = "http"
      protocol    = "TCP"
      port        = var.port
      target_port = var.port
    }
    <% }%>
  }
}


resource "kubernetes_deployment" "demo_app_spring_deployment" {
  metadata {
    name      = "demo-app-spring"
    namespace = var.namespace
    labels = {
      app = "demo-app-spring"
    }
  }


  spec {
    selector {
      match_labels = {
        app = "demo-app-spring"
      }
    }

    template {
      metadata {
        labels = {
          app = "demo-app-spring"
        }
      }

      spec {
        container {
          name  = "demo-app-spring"
          image = "raxkumar/k8s-terraform-spring-postgres:latest"
          port {
            name           = "http"
            container_port = var.port
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
          }

          env {
            name  = "DB_SERVER"
            value = <%- "\""+postgreServerName+"\"" %>
          }

          env {
            name  = "DB_PASSWORD"
            value = <%- "\""+postgrePassword+"\"" %>
          }

          env {
            name  = "DB_NAME"
            value = <%- "\""+postgreDatabaseName+"\"" %>
          }

          env {
            name  = "DB_USER"
            value = <%- "\""+postgreUserName+"\"" %>
          }
        }
      }
    }
  }
}
