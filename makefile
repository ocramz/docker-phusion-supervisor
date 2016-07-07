ACCOUNT = ocramz
PROJECT = docker-phusion-supervisor
TAG = $(ACCOUNT)/$(PROJECT)

.DEFAULT_GOAL := help

help:
	@echo "Use \`make <target>\` where <target> is one of"
	@echo "  help     to display this help message"
	@echo "  build  build Docker container"
	@echo "  run    run the container"
	@echo "  rbuild build image on Docker hub"


build:
	docker build -t ${TAG} .

run:
	docker run --rm -it ${TAG}

rbuild:
	curl -H "Content-Type: application/json" --data '{"build": true}' -X POST https://registry.hub.docker.com/u/ocramz/docker-phusion-supervisor/trigger/2cc05e87-ad52-4c60-b422-d704a2f25c6d/

