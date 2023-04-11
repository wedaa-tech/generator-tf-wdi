resource "kubernetes_service" "nodejs-service" {
  metadata {
    name      = "nodejs-service"
    namespace = var.namespace
    labels = {
      app = "nodejs"
    }
  }

  spec {
    selector = {
      app = "nodejs"
    }

    type = "NodePort"
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 3001
      target_port = 3001
      node_port   = 30003
    }
  }
}


resource "kubernetes_deployment" "nodejs-kc-deployment" {
  metadata {
    name      = "nodejs-deployment"
    namespace = var.namespace
    labels = {
      app = "nodejs"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "nodejs"
      }
    }

    strategy {
      type = "Recreate"
    }

    template {
      metadata {
        labels = {
          app = "nodejs"
        }
      }

      spec {
        container {
          image = "raxkumar/k8s-terraform-react-keycloak:latest" # Provide react app image url
          name  = "nodejs"
          env {
            name  = "nodeEnv"
            value = "val"
          }
          port {
            name           = "nodejs"
            container_port = var.port
          }
        }
      }
    }
  }
}
