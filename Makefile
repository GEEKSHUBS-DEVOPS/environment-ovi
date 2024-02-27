angular-cli:
	docker compose -f ./deploy/develop/tools.yaml run -it --rm angular-cli 
nestjs-cli:
	docker compose -f ./deploy/develop/tools.yaml run -it --rm nestjs-cli 
start:
	docker compose -f ./deploy/develop/docker-compose.yaml up -d && \
	docker compose -f ./deploy/develop/docker-compose.yaml logs -f