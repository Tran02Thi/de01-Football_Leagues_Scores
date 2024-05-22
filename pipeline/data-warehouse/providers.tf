provider "google" {
  credentials = file("D://dbt-trino-bigquery//trino//catalog//etl-pipeline-key.json")
  project     = var.project_id
}