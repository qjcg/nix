IMG_NAME := nix-workstation

build:
	docker build -t $(IMG_NAME) .
.PHONY: build

# Run the container with:
# - ~/.ssh mounted at /root/.ssh for access to SSH keys.
# - ~/src mounted at /src for persistence.
# - All ports mapped to random high ports on the host
run:
	docker run \
		--name workstation -it -P --rm \
		-v ~/.ssh:/root/.ssh \
		-v ~/src:/src \
		-v ~/go:/root/go \
		-w /src \
		$(IMG_NAME)
.PHONY: run

clean:
	-docker container prune -f
	-docker image prune -f
.PHONY: clean
