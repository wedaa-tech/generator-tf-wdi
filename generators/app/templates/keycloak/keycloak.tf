resource "kubernetes_service" "keycloak_service" {
  metadata {
    name      = "keycloak-service"
    namespace = var.namespace
    labels = {
      app = "keycloak"
    }
  }

  spec {
    selector = {
      app = "keycloak"
    }
    <%if(cloudProvider == "minikube") {%>
    type = "NodePort"
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
      node_port   = 30010
    }
    <% } else if (cloudProvider == "aws") { %>
    type = "ClusterIP"
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }
    <% }%>
  }
  depends_on = [
    kubernetes_deployment.postgres_deployment,
    kubernetes_service.postgres_service
  ]
}


resource "kubernetes_deployment" "keyloak_deployment" {
  metadata {
    name      = "keyloak-deployment"
    namespace = var.namespace
    labels = {
      app = "keycloak"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "keycloak"
      }
    }

    strategy {
      type = "Recreate"
    }

    template {
      metadata {
        labels = {
          app = "keycloak"
        }
      }

      spec {
        container {
          image = "quay.io/keycloak/keycloak:20.0.2" # Provide keycloak image url
          name  = "keycloak"

          env {
            name = "KEYCLOAK_ADMIN"
            value_from {
              config_map_key_ref {
                key  = "keycloak-admin-username"
                name = kubernetes_config_map.keycloak_config_map.metadata.0.name
              }
            }
          }

          env {
            name = "KEYCLOAK_ADMIN_PASSWORD"
            value_from {
              secret_key_ref {
                key  = "keycloak-admin-password"
                name = kubernetes_secret.keycloak_secret.metadata.0.name
              }
            }
          }

          env {
            name = "KC_DB_VENDOR"
            value_from {
              config_map_key_ref {
                key  = "keycloak-db-vendor"
                name = kubernetes_config_map.keycloak_config_map.metadata.0.name
              }
            }
          }

          env {
            name = "KC_DB"
            value_from {
              config_map_key_ref {
                key  = "keycloak-db"
                name = kubernetes_config_map.keycloak_config_map.metadata.0.name
              }
            }
          }

          env {
            name = "KC_DB_ADDR"
            value_from {
              config_map_key_ref {
                key  = "keycloak-db-addr"
                name = kubernetes_config_map.keycloak_config_map.metadata.0.name
              }
            }
          }

          env {
            name = "KC_DB_DATABASE"
            value_from {
              config_map_key_ref {
                key  = "keycloak-db-name"
                name = kubernetes_config_map.keycloak_config_map.metadata.0.name
              }
            }
          }


          env {
            name = "KC_DB_USERNAME"
            value_from {
              config_map_key_ref {
                key  = "keycloak-db-username"
                name = kubernetes_config_map.keycloak_config_map.metadata.0.name
              }
            }
          }

          env {
            name = "KC_DB_PASSWORD"
            value_from {
              secret_key_ref {
                key  = "keycloak-db-password"
                name = kubernetes_secret.keycloak_secret.metadata.0.name
              }
            }
          }

          env {
            name = "KC_DB_URL"
            value_from {
              config_map_key_ref {
                key  = "keycloak-db-url"
                name = kubernetes_config_map.keycloak_config_map.metadata.0.name
              }
            }
          }

          command = ["/opt/keycloak/bin/kc.sh"]
          args    = ["start-dev"]

          port {
            name           = "keycloak"
            container_port = 8080
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_deployment.postgres_deployment,
    kubernetes_service.postgres_service
  ]
}
