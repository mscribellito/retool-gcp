// Create api service

module "retool_api" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "0.4.0"

  service_name = "retool-api"
  project_id   = var.project_id
  location     = var.region

  env_vars = concat(
    [{
      name  = "SERVICE_TYPE"
      value = "MAIN_BACKEND,DB_CONNECTOR"
    }],
    local.env_vars
  )

  env_secret_vars = flatten([
    for s in local.env_secret_vars : {
      name = s.name,
      value_from = [{
        secret_key_ref = {
          name = s.value_from,
        key = "latest" }
      }]
    }
  ])

  image = local.retool_image
  container_command = [
    "./docker_scripts/start_api.sh",
  ]

  ports = {
    "name" : "http1",
    "port" : 3000
  }

  limits = {
    cpu    = var.service_cpu
    memory = var.service_memory
  }

  members = ["allUsers"]

  service_account_email = module.retool_service_account.email

  template_annotations = {
    "autoscaling.knative.dev/minScale"      = 0
    "autoscaling.knative.dev/maxScale"      = 1
    "generated-by"                          = "terraform"
    "run.googleapis.com/client-name"        = "terraform"
    "run.googleapis.com/cloudsql-instances" = module.retool_database.instance_connection_name
  }

  depends_on = [time_sleep.wait_activate_apis]
}

// Create jobs-runner job

resource "google_cloud_run_v2_job" "retool_jobs_runner" {
  project = var.project_id

  name         = "retool-jobs-runner"
  location     = var.region
  launch_stage = "BETA"

  template {

    template {

      containers {
        env {
          name  = "SERVICE_TYPE"
          value = "JOBS_RUNNER"
        }

        dynamic "env" {
          for_each = local.env_vars
          content {
            name  = env.value["name"]
            value = env.value["value"]
          }
        }

        dynamic "env" {
          for_each = local.env_secret_vars
          content {
            name = env.value["name"]
            value_source {
              secret_key_ref {
                secret  = env.value["value_from"]
                version = "latest"
              }
            }
          }
        }

        image = local.retool_image
        command = [
          "./docker_scripts/start_api.sh",
        ]

        resources {
          limits = {
            cpu    = var.service_cpu
            memory = var.service_memory
          }
        }

        volume_mounts {
          name       = "cloudsql"
          mount_path = "/cloudsql"
        }
      }

      volumes {
        name = "cloudsql"
        cloud_sql_instance {
          instances = [module.retool_database.instance_connection_name]
        }
      }

      timeout = "1800s"

      service_account = module.retool_service_account.email

    }

  }
}