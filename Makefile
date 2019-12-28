IMG_NAME := nix-workstation

.PHONY: build
build:
	docker build -t $(IMG_NAME) .

.PHONY: clean
clean:
	-docker container prune -f
	-docker image prune -f
