IMAGE_NAME = fredipevcin/edavki
CONTAINER_NAME = edavki

.DEFAULT_GOAL := help
.PHONY: help
help:
	@grep -E '^[a-zA-Z_/%\-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup: docker/build ## Setup project
	mkdir -p "$(CURDIR)/data" "$(CURDIR)/firefox"

docker/build: ## Builds docker image
	docker build --target=novnc -t $(IMAGE_NAME):novnc .
	docker build --target=vnc -t $(IMAGE_NAME):vnc .

docker/console:
	docker run --rm -ti -v "$(CURDIR)/data":/root/data -w /root $(IMAGE_NAME):vnc bash

run/novnc: ## Runs firefox without vnc
	docker run --rm -ti \
		--name $(CONTAINER_NAME) \
		--hostname $(CONTAINER_NAME) \
		-v "$(CURDIR)/firefox":/root/.mozilla/firefox \
		-v "$(CURDIR)/data":/root/data \
		-w /root \
		-e DISPLAY=unix$(DISPLAY) \
		-v /etc/localtime:/etc/localtime:ro \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		$(IMAGE_NAME):novnc

run/vnc: ## Runs firefox with vnc
	docker run --rm -ti \
		-p 5900:5900 \
		--name $(CONTAINER_NAME) \
		--hostname $(CONTAINER_NAME) \
		-v "$(CURDIR)/firefox":/root/.mozilla/firefox \
		-v "$(CURDIR)/data":/root/data \
		-w /root \
		$(IMAGE_NAME):vnc


connect: ## Connect via VNC
	open vnc://127.0.0.1:5900

publish: ## Publish docker images
	docker push $(IMAGE_NAME):novnc
	docker push $(IMAGE_NAME):vnc