# Self-hosted Retool on GCP

[Self-hosted Retool](https://retool.com/self-hosted/) deployment on GCP backed by Cloud Run and SQL. Based on [examples from Retool](https://github.com/tryretool/retool-onpremise) and their [documentation](https://docs.retool.com/docs/self-hosted).

## Prerequisites

* `artifactregistry.googleapis.com` API enabled.
* Artifact Registry repository named `retool`.
* [tryretool/backend](https://hub.docker.com/r/tryretool/backend) image pushed as `backend:<version-number>`

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.52.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.52.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_retool_api_jobs_runner"></a> [retool\_api\_jobs\_runner](#module\_retool\_api\_jobs\_runner) | GoogleCloudPlatform/cloud-run/google | 0.4.0 |
| <a name="module_retool_database"></a> [retool\_database](#module\_retool\_database) | GoogleCloudPlatform/sql-db/google//modules/postgresql | 14.0.0 |
| <a name="module_retool_secrets"></a> [retool\_secrets](#module\_retool\_secrets) | GoogleCloudPlatform/secret-manager/google | 0.1.1 |
| <a name="module_retool_service_account"></a> [retool\_service\_account](#module\_retool\_service\_account) | terraform-google-modules/service-accounts/google | 4.2.0 |

## Resources

| Name | Type |
|------|------|
| [google_project_service.activate_apis](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/project_service) | resource |
| [google_sql_user.retool_database_user](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/sql_user) | resource |
| [random_password.encryption_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.jwt_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [time_sleep.wait_activate_apis](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [google_secret_manager_secret_version.retool_database_password](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/data-sources/secret_manager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_activate_apis"></a> [activate\_apis](#input\_activate\_apis) | The list of APIs & services to activate within the project. | `list(string)` | <pre>[<br>  "compute.googleapis.com",<br>  "run.googleapis.com",<br>  "secretmanager.googleapis.com",<br>  "sqladmin.googleapis.com"<br>]</pre> | no |
| <a name="input_database_tier"></a> [database\_tier](#input\_database\_tier) | The machine type for the database instance. | `string` | `"db-f1-micro"` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | The database version to use. | `string` | `"POSTGRES_11"` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Artifact Registry container image name for Retool. | `string` | `"backend"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy in. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region of the deployment. | `string` | `"us-east1"` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | Artifact Registry repository name. | `string` | `"retool"` | no |
| <a name="input_retool_license_key"></a> [retool\_license\_key](#input\_retool\_license\_key) | Retool license key. | `string` | `"EXPIRED-LICENSE-KEY-TRIAL"` | no |
| <a name="input_retool_version"></a> [retool\_version](#input\_retool\_version) | Retool version number. | `string` | n/a | yes |
| <a name="input_service_cpu"></a> [service\_cpu](#input\_service\_cpu) | Number of vCPUs allocated to each container instance. | `string` | `"1000m"` | no |
| <a name="input_service_memory"></a> [service\_memory](#input\_service\_memory) | Memory to allocate to each container instance. | `string` | `"2Gi"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone of the deployment. | `string` | `"us-east1-b"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_url"></a> [url](#output\_url) | The DNS name of the Cloud Run service. |
