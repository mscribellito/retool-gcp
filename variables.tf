variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "zone" {
  type    = string
  default = "us-east1-b"
}

variable "apis_and_services" {
  type = list(string)
  default = [
    "compute.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "sqladmin.googleapis.com",
  ]
}

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

variable "retool_version" {
  type        = string
  description = "Retool version number."
}

variable "retool_license_key" {
  type        = string
  description = "Retool license key."
  default     = "EXPIRED-LICENSE-KEY-TRIAL"
}
