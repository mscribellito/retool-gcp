# Self-hosted Retool on GCP

Self-hosted Retool deployment on GCP backed by Cloud Run and SQL. Based on [examples from Retool](https://github.com/tryretool/retool-onpremise) and the [self-hosted Retool documentation](https://docs.retool.com/docs/self-hosted).

## Prerequisites

* `artifactregistry.googleapis.com` API enabled.
* Artifact Registry repository named `retool`.
* [tryretool/backend](https://hub.docker.com/r/tryretool/backend) image pushed as `backend:<version-number>`
