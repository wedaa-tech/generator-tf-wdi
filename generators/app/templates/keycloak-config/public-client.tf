
resource "keycloak_openid_client" "openid_client" {
  realm_id            = keycloak_realm.realm.id
  client_id           = <%- "\""+keycloakPublicClient+"\"" %>  # Provide public client name
  name                = <%- "\""+keycloakPublicClient+"\"" %>  # Provide public client name
  enabled             = true
  standard_flow_enabled = true
  access_type         = "PUBLIC"

  valid_redirect_uris = [
    <%- "\""+domain+"\""%>
  ]

  valid_post_logout_redirect_uris = [
    <%- "\""+domain+"\""%>
  ]

  web_origins = ["+"]

  login_theme = "keycloak"
  cleanup_on_fail = true
  force_update    = false
  # extra_config = {
  #   "key1" = "value1"
  #   "key2" = "value2"
  # }
}