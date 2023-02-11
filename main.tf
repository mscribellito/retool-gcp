// Enable necessary APIs & services

resource "google_project_service" "activate_apis" {
  for_each = toset(var.activate_apis)

  project = var.project_id
  service = each.value
}

resource "time_sleep" "wait_activate_apis" {
  create_duration = "120s"

  depends_on = [google_project_service.activate_apis]
}

locals {
  secret_database_password = "retool-database-password"
  secret_jwt_secret        = "retool-jwt-secret"
  secret_encryption_key    = "retool-encryption-key"
  secret_license_key       = "retool-license-key"

  database_name = "hammerhead_production"
  database_user = "retool"

  retool_image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_name}/${var.image_name}:${var.retool_version}"
}
