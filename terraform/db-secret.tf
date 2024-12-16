resource "kubernetes_secret" "db_credentials" {
  metadata {
    name = "db-credentials"
  }

  data = {
    DB_NAME = base64encode(google_sql_database.postgres_database.name)
    DB_USER = base64encode(google_sql_user.db_user.name)
    DB_PASS = base64encode(var.db_password)
    DB_HOST = base64encode(google_sql_database_instance.postgres_instance.connection_name)
    DB_PORT = base64encode("5432") 
  }
}
