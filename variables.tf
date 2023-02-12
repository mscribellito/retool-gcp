// General GCP

variable "project_id" {
  type        = string
  description = "The project ID to deploy in."
}

variable "region" {
  type        = string
  description = "The region of the deployment."
  default     = "us-east1"
}

variable "zone" {
  type        = string
  description = "The zone of the deployment."
  default     = "us-east1-b"
}

variable "activate_apis" {
  type        = list(string)
  description = "The list of APIs & services to activate within the project."
  default = [
    "compute.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "sqladmin.googleapis.com",
  ]
}

// Cloud SQL

variable "database_version" {
  type        = string
  description = "The database version to use."
  default     = "POSTGRES_11"
}

variable "database_tier" {
  type        = string
  description = "The machine type for the database instance."
  default     = "db-f1-micro"
}

// Cloud Run

variable "service_cpu" {
  type        = string
  description = "Number of vCPUs allocated to each container instance."
  default     = "1000m"
}

variable "service_memory" {
  type        = string
  description = "Memory to allocate to each container instance."
  default     = "2Gi"
}

// Artifact Registry

variable "repository_name" {
  type        = string
  description = "Artifact Registry repository name."
  default     = "retool"
}

variable "image_name" {
  type        = string
  description = "Artifact Registry container image name for Retool."
  default     = "backend"
}

// Retool Specific

variable "retool_version" {
  type        = string
  description = "Retool version number."
}

variable "retool_license_key" {
  type        = string
  description = "Retool license key."
  default     = "EXPIRED-LICENSE-KEY-TRIAL"
}
