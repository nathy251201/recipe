terraform {
  backend "gcs" {
    bucket      = "terraform-state-recipe"
    prefix      = "terraform/recipe-state"
    credentials = "./credentials.json"

  }
}

provider "google" {
  credentials = file("credentials.json")
  project     = var.project_id
  region      = var.region
}