run_bronze:
	dbt run --project-dir ./bronze --profiles-dir ./ --full-refresh


run_silver:
	dbt run --project-dir ./silver --profiles-dir ./ --full-refresh


run_gold:
	dbt run --project-dir ./gold --profiles-dir ./ --full-refresh

run_all:
	make run_bronze && make run_silver && make run_gold

docs_silver:
	dbt docs generate --project-dir ./silver --profiles-dir ./ && dbt docs serve --port 8081 --project-dir ./silver --profiles-dir ./

docs_gold:
	dbt docs generate --project-dir ./gold --profiles-dir ./ && dbt docs serve --port 8081 --project-dir ./gold --profiles-dir ./


