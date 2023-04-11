resource "kubernetes_service" "react-service" {
  metadata {
    name      = "react-service"
    namespace = var.namespace
    labels = {
      app  = "react-kc"
    }
  }

  spec {
    selector = {
       app  = "react-kc"
    }
    <%if(cloudProvider == "minikube") {%>
    type = "NodePort"
      port {
        name        = "http"
        protocol    = "TCP"
        port        = var.port
        target_port = var.port
        node_port   = 30002
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


resource "kubernetes_deployment" "react-kc-deployment" {
  metadata {
    name      = "react-kc-deployment"
    namespace =  var.namespace
    labels = {
       app  = "react-kc"
    }
  }

  spec {
    selector {
      match_labels = {
        app  = "react-kc"
      }
    }

    strategy {
      type = "Recreate"
    }

    template {
      metadata {
        labels = {
          app  = "react-kc"
        }
      }

      spec {
        container {
          image = <%- "\""+reactImage+"\"" %>
          name  = "react-kc"
          <% if(keycloak){%>
          env {
            name = "REACT_APP_KEYCLOAK_URL"
            value = <%- "kc.\""+domain+"\""%>
          }

          env {
            name = "REACT_APP_KEYCLOAK_REALM"
            value = <%- "\""+keycloakRealmName+"\"" %>
          }

          env {
            name = "REACT_APP_KEYCLOAK_CLIENT_ID"
            value = <%- "\""+keycloakPublicClient+"\"" %>
          }

          env {
            name = "REACT_APP_BACKEND_API_URL"
            value = <%- "be.\""+domain+"\""%>
          }
          <%}%>

          port {
            name           = "react"
            container_port = var.port
          }
        }
      }
    }
  }
}