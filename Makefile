IMAGE_NAME = fredipevcin/edavki-vnc
CONTAINER_NAME = edavki

.DEFAULT_GOAL := help
.PHONY: help
help:
	@grep -E '^[a-zA-Z_/%\-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup: docker/build ## Setup project
	mkdir -p "$(CURDIR)/data" "$(CURDIR)/firefox"

docker/build: ## Builds docker image
	docker build -t $(IMAGE_NAME) .

docker/console:
	docker exec -ti `docker ps -qf "name=${CONTAINER_NAME}"` bash

run: ## Runs container
	docker run -p 5900:5900 --name $(CONTAINER_NAME) --rm -ti -v "$(CURDIR)/firefox":/root/.mozilla/firefox -v "$(CURDIR)/data":/root/data -w /root $(IMAGE_NAME)

connect: ## Connect via VNC
	open vnc://127.0.0.1:5900
