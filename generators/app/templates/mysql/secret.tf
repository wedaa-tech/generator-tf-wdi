resource "kubernetes_secret" "demo_app_secret" {
  metadata {
    name      = "mysql-pass"
    namespace = <%- "\""+namespace+"\"" %> # Provide namespace here, default is "wdi"
  }

  data = {
    mysql-root-password = "root"
    mysql-user-password = "user"
  }
}

# resource "kubernetes_secret" "docker_secret" {
#   metadata {
#     name = "docker-cfg"
#     namespace = kubernetes_namespace.demo_app_ns.metadata.0.name
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
