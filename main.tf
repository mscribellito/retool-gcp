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
  retool_image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_name}/${var.image_name}:${var.retool_version}"
}
