# Self-hosted Retool on GCP

Self-hosted Retool deployment on GCP backed by Cloud Run and SQL.

## Prerequisites

* `artifactregistry.googleapis.com` API enabled.
* Artifact Registry repository named `retool`.
* [tryretool/backend](https://hub.docker.com/r/tryretool/backend) image pushed as `backend:<version-number>`
