user = 1000
group = 1000

angular-cli: ## lanza un cliente de angular para operaciones
	docker compose -f ./deploy/develop/tools.yaml run -it --rm angular-cli 
nestjs-cli: ## lanza un cliente de nestjs para operaciones
	docker compose -f ./deploy/develop/tools.yaml run -it --rm nestjs-cli 
start: ## inicializa los servicios
	docker compose -f ./deploy/develop/docker-compose.yaml up -d && \
	docker compose -f ./deploy/develop/docker-compose.yaml logs -f
install: ## instala las dependencias
	docker compose -f ./deploy/develop/docker-compose.yaml run --rm -u $(user):$(group) frontend bash -c \
			"npm install"
	docker compose -f ./deploy/develop/docker-compose.yaml run --rm -u $(user):$(group) api bash -c \
			"npm install"

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'