resource "kubernetes_service" "postgres_service" {
  metadata {
    name      = "postgres-db"
    namespace = var.namespace
    labels = {
      app = "demo-app"
    }
  }

  spec {
    selector = {
      app = kubernetes_deployment.postgres_deployment.metadata.0.labels.app
    }

    port {
      port = 5432
    }

    cluster_ip = "None"
  }
}

# resource "kubernetes_persistent_volume_claim" "demo_app_pvc" {
#   metadata {
#     name      = "mysql-pvc"
#     namespace = kubernetes_namespace.demo_app_ns.metadata.0.name
#     labels = {
#       app = "demo-app"
#     }
#   }

#   spec {
#     access_modes = ["ReadWriteOnce"]

#     resources {
#       requests = {
#         storage = "1Gi"
#       }
#     }
#   }    type = "NodePort"
# }

resource "kubernetes_deployment" "postgres_deployment" {
  metadata {
    name      = "postgres-db"
    namespace = var.namespace
    labels = {
      app = "demo-app"
    }
  }

  spec {
    selector {
      match_labels = {
        app  = "demo-app"
        tier = "postgres"
      }
    }

    strategy {
      type = "Recreate"
    }

    template {
      metadata {
        labels = {
          app  = "demo-app"
          tier = "postgres"
        }
      }

      spec {
        container {
          image = "postgres:latest"
          name  = "postgres"

          env {
            name = "POSTGRES_DB"
            value_from {
              config_map_key_ref {
                key  = "database-name"
                name = kubernetes_config_map.postgres_cm.metadata.0.name

              }
            }
          }

          env {
            name = "POSTGRES_USER"
            value_from {
              config_map_key_ref {
                key  = "username"
                name = kubernetes_config_map.postgres_cm.metadata.0.name

              }
            }
          }

          env {
            name = "POSTGRES_PASSWORD"
            value_from {
              secret_key_ref {
                key  = "password"
                name = kubernetes_secret.postgres_secret.metadata.0.name

              }
            }
          }

          liveness_probe {
            tcp_socket {
              port = 5432
            }
          }

          port {
            name           = "postgres"
            container_port = 5432
          }

          # volume_mount {
          #   name       = "mysql-persistent-storage"
          #   mount_path = "/var/lib/mysql"
          # }
        }

        # volume {
        #   name = "mysql-persistent-storage"
        #   persistent_volume_claim {
        #     claim_name = kubernetes_persistent_volume_claim.demo_app_pvc.metadata.0.name
        #   }
        # }

      }
    }
  }
}

