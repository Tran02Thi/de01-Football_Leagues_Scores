resource "null_resource" "setup_lakehouse" {
    provisioner "local-exec" {
        command = "docker-compose -f D://dbt-trino-bigquery//dremio//docker-compose.yml up -d"
    }
}
