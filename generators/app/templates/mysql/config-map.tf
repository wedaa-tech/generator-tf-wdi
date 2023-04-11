resource "kubernetes_config_map" "demo_app_cm" {
  metadata {
    name = "mysql-config-map"
    namespace = "wdi"  # Provide namespace here, default is "wdi"
  }

  data = {
    mysql-server        = "demo-app-mysql"
    mysql-database-name = "demoDb"
    mysql-user-username = "myUser"
  }
}
