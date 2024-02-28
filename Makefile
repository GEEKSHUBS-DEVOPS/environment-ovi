user = 1000
group = 1000
tools = ./deploy/develop/tools.yaml
services = ./deploy/develop/docker-compose.yaml


angular-cli: ## lanza un cliente de angular para operaciones
	docker compose -f $(tools) run -it --rm -u $(user):$(group) angular-cli 
angular-cli-legacy: ## lanza un cliente de angular con version antigua para operaciones en proyectos heredados
	docker compose -f $(tools) run -it --rm -u $(user):$(group) angular-cli-legacy
nestjs-cli: ## lanza un cliente de nestjs para operaciones
	docker compose -f $(tools) run -it --rm -u $(user):$(group) nestjs-cli 
start: ## inicializa los servicios
	docker compose -f $(services) up -d && \
	docker compose -f $(services) logs -f
install: ## instala las dependencias
	docker compose -f $(services) run --rm -u $(user):$(group) frontend bash -c \
			"npm install"
	docker compose -f $(services) run --rm -u $(user):$(group) control-panel bash -c \
			"npm install"
	docker compose -f $(services) run --rm -u $(user):$(group) api bash -c \
			"npm install"
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

git: ## lanza una consola con cliente de git para operaciones
	docker compose -f $(tools) run -it --rm -u $(user):$(group) git

rebuild: ## reconstruye las imagenes del proyecto
	docker compose -f $(tools) -f $(services) build --no-cache