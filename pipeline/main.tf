resource "null_resource" "run_docker_compose" {
    provisioner "local-exec" {
        command = "docker-compose -f D://dbt-trino-bigquery//docker-compose.yaml up -d"
    }

    lifecycle {
        prevent_destroy = false
    }
}


# END