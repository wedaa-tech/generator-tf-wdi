resource "kubernetes_secret" "postgres_secret" {
  metadata {
    name      = "postgres-secret"
    namespace = var.namespace
  }

  data = {
    password = <%- "\""+postgrePassword+"\"" %>
  }
}

# resource "kubernetes_secret" "docker_secret" {
#   metadata {
#     name = "docker-cfg"
#     namespace = kubernetes_namespace.demo_app_ns.metadata.0.nameo
#   }

#   data = {
#     ".dockerconfigjson" = jsonencode({
#       auths = {
#         "${var.registry_server}" = {
#           auth = "${base64encode("${var.registry_username}:${var.registry_password}")}"
#         }
#       }
#     })
#   }

#   type = "kubernetes.io/dockerconfigjson"
# }
