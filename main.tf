// Enable necessary APIs & services

resource "google_project_service" "apis_and_services" {
  for_each = toset(var.apis_and_services)

  project = var.project_id
  service = each.value
}

resource "time_sleep" "wait_apis_and_services" {
  create_duration = "60s"

  depends_on = [google_project_service.apis_and_services]
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
