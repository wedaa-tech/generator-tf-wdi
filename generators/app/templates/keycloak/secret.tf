resource "kubernetes_secret" "keycloak_secret" {
  metadata {
    name = "keycloak-pass"
    namespace = var.namespace
  }
  data = {
    keycloak-admin-password = <%- "\""+keycloakAdminUser+"\"" %>  # Provide admin username for keycloak(admin-cli)
    keycloak-db-password    = <%- "\""+keycloakDBPassword+"\"" %> # provide db password for keycloak
  }
}
