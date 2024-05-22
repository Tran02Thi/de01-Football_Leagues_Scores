
up:
	terraform apply

down:
	docker-compose down 

reset:
	make down & make up
