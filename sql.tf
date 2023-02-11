module "retool_database" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "14.0.0"

  name             = "retool"
  database_version = "POSTGRES_11"
  project_id       = var.project_id
  zone             = var.zone
  region           = var.region
  tier             = "db-custom-1-3840"

  additional_databases = [
    {
      name      = "hammerhead_production"
      charset   = "UTF8"
      collation = "en_US.UTF8"
    }
  ]

  database_flags = [
    {
      name  = "max_connections"
      value = "300"
    }
  ]

  enable_default_db   = false
  enable_default_user = false

  deletion_protection = true

  ip_configuration = {
    ipv4_enabled        = true
    private_network     = null
    require_ssl         = true
    allocated_ip_range  = null
    authorized_networks = []
  }

  create_timeout = "30m"
}

resource "google_sql_user" "retool_database_user" {
  instance = module.retool_database.instance_name

  name     = "retool"
  password = data.google_secret_manager_secret_version.retool_database_password.secret_data
}
