output "instance_connection_name" {
  value = google_sql_database_instance.postgres_instance.connection_name
}

output "database_name" {
  value = google_sql_database.postgres_database.name
}
output "db_connection_name" {
  value = google_sql_database_instance.postgres_instance.connection_name
}

output "db_user" {
  value = google_sql_user.db_user.name
}

output "db_name" {
  value = google_sql_database.postgres_database.name
}
