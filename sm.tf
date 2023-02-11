resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "encryption_key" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "jwt_secret" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

// database password, JWT secret, encryption key & license key

module "retool_secrets" {
  source  = "GoogleCloudPlatform/secret-manager/google"
  version = "0.1.1"

  project_id = var.project_id

  secrets = [
    {
      name                  = "retool-database-password"
      automatic_replication = true
      secret_data           = random_password.password.result
    },
    {
      name                  = "retool-jwt-secret"
      automatic_replication = true
      secret_data           = random_password.jwt_secret.result
    },
    {
      name                  = "retool-encryption-key"
      automatic_replication = true
      secret_data           = random_password.encryption_key.result
    },
    {
      name                  = "retool-license-key"
      automatic_replication = true
      secret_data           = var.retool_license_key
    }
  ]
}

data "google_secret_manager_secret_version" "retool_database_password" {
  project = var.project_id

  secret = "retool-database-password"

  depends_on = [module.retool_secrets]
}
