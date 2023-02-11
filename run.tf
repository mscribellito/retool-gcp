// Create api & jobs-runner service

module "retool_api_jobs_runner" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "0.4.0"

  service_name = "retool-api-jobs-runner"
  project_id   = var.project_id
  location     = var.region
  env_vars = [
    {
      name  = "NODE_ENV"
      value = "production"
    },
    {
      name  = "SERVICE_TYPE"
      value = "MAIN_BACKEND,DB_CONNECTOR,JOBS_RUNNER"
    },
    {
      name  = "POSTGRES_DB"
      value = local.database_name
    },
    {
      name  = "POSTGRES_HOST"
      value = "/cloudsql/${module.retool_database.instance_connection_name}"
    },
    {
      name  = "POSTGRES_SSL_ENABLED"
      value = "false"
    },
    {
      name  = "POSTGRES_PORT"
      value = "5432"
    },
    {
      name  = "POSTGRES_USER"
      value = local.database_user
    }
  ]
  env_secret_vars = [
    {
      name = "POSTGRES_PASSWORD"
      value_from = [{
        secret_key_ref = {
          name = local.secret_database_password
          key  = "latest"
        }
      }]
    },
    {
      name = "JWT_SECRET"
      value_from = [{
        secret_key_ref = {
          name = local.secret_jwt_secret
          key  = "latest"
        }
      }]
    },
    {
      name = "ENCRYPTION_KEY"
      value_from = [{
        secret_key_ref = {
          name = local.secret_encryption_key
          key  = "latest"
        }
      }]
    },
    {
      name = "LICENSE_KEY"
      value_from = [{
        secret_key_ref = {
          name = local.secret_license_key
          key  = "latest"
        }
      }]
    }
  ]
  image = local.retool_image
  container_command = [
    "./docker_scripts/start_api.sh",
  ]

  limits = {
    cpu    = var.service_cpu
    memory = var.service_memory
  }
  members = ["allUsers"]
  ports = {
    "name" : "http1",
    "port" : 3000
  }
  service_account_email = module.retool_service_account.email
  template_annotations = {
    "autoscaling.knative.dev/minScale"      = 1
    "autoscaling.knative.dev/maxScale"      = 1
    "generated-by"                          = "terraform"
    "run.googleapis.com/client-name"        = "terraform"
    "run.googleapis.com/cloudsql-instances" = module.retool_database.instance_connection_name
  }

  depends_on = [time_sleep.wait_apis_and_services]
}
