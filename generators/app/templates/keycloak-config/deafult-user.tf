resource "keycloak_user" "user_with_initial_password" {
  realm_id = keycloak_realm.realm.id
  username = <%- "\""+ keycloakDefaultUser+"\"" %>  # Provide username
  enabled  = true

  email      = <%- "\""+keycloakEmail+"\"" %>  # Provide email
  first_name = <%- "\""+keycloakFirstName+"\"" %>  # Provide first name
  last_name  = <%- "\""+keycloakLastName+"\"" %> # Provide last name

  initial_password {
    value     = <%- "\""+keycloakDefaultUserPassword+"\"" %>  # Provide initial password
    temporary = false
  }
  cleanup_on_fail = true
  force_update    = false
}
