
resource "google_sql_database_instance" "postgres_instance" {
  name             = var.db_instance_name
  database_version = "POSTGRES_14"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}


resource "google_sql_database" "postgres_database" {
  name     = var.db_name
  instance = google_sql_database_instance.postgres_instance.name
}

resource "google_sql_user" "db_user" {
  name     = var.db_user
  password = var.db_password
  instance = google_sql_database_instance.postgres_instance.name
}