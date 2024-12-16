variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Region for GKE cluster"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "kubernetes-cluster"
}

variable "node_machine_type" {
  description = "Machine type for GKE nodes"
  type        = string
  default     = "e2-medium"
}

variable "node_count" {
  description = "Number of nodes in the GKE cluster"
  type        = number
  default     = 3
}


variable "db_instance_name" {
  description = "Nome da instância do banco de dados"
  default     = "postgres-instance"
}

variable "db_name" {
  description = "Nome do banco de dados"
  default     = "my_database"
}

variable "db_user" {
  description = "Usuário administrador do banco de dados"
  default     = "admin"
}

variable "db_password" {
  description = "Senha para o usuário do banco de dados"
  default     = "change_this_password"
}