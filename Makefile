IMG_NAME := nix-workstation

.PHONY: build
build:
	docker build -t $(IMG_NAME) .

.PHONY: run
run:
	docker run -it --rm -v ~/src:/src -w /src --name workstation $(IMG_NAME)

.PHONY: clean
clean:
	-docker container prune -f
	-docker image prune -f
