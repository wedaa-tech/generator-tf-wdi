resource "kubernetes_config_map" "postgres_cm" {
  metadata {
    name      = "postgres-config-map"
    namespace = var.namespace
  }

  data = {
    server-name   = <%- "\""+postgreServerName+"\"" %>
    database-name = <%- "\""+postgreDatabaseName+"\"" %>
    username      = <%- "\""+postgreUserName+"\"" %>
  }
}
