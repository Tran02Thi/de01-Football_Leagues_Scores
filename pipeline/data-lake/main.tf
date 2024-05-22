resource "null_resource" "wait_docker_compose" {
    provisioner "local-exec" {
        command = "sleep 20"
    }
}

resource "null_resource" "run_bronze" {
    provisioner "local-exec" {
        command = "dbt run --project-dir D://dbt-trino-bigquery//transfermarkt_analytics//bronze"
    }

    depends_on = [null_resource.wait_docker_compose]
}

resource "null_resource" "wait_bronze" {
    provisioner "local-exec" {
        command = "sleep 20"
    }

    depends_on = [null_resource.run_bronze]
}

resource "null_resource" "run_silver" {
    provisioner "local-exec" {
        command = "dbt run --project-dir D://dbt-trino-bigquery//transfermarkt_analytics//silver"
    }

    depends_on = [
        null_resource.run_bronze
    ]
}

resource "null_resource" "wait_silver" {
    provisioner "local-exec" {
        command = "sleep 20"
    }

    depends_on = [null_resource.run_silver]
}

resource "null_resource" "run_gold" {
    provisioner "local-exec" {
        command = "dbt run --project-dir D://dbt-trino-bigquery//transfermarkt_analytics//gold"
    }

    depends_on = [
        null_resource.run_bronze,
        null_resource.run_silver
    ]
}