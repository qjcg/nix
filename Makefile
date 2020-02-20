IMG_NAME := nix-workstation
CMD_SWITCH := sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch -I nixos-config=configuration.nix


.PHONY: switch
switch:
	$(CMD_SWITCH)

.PHONY: upgrade
upgrade:
	$(CMD_SWITCH) --upgrade


.PHONY: docker-build
docker-build:
	docker build -t $(IMG_NAME) .

# Run the container with:
# - ~/.ssh mounted at /root/.ssh for access to SSH keys.
# - ~/src mounted at /src for persistence.
# - All ports mapped to random high ports on the host
.PHONY: docker-run
docker-run:
	docker run \
		--name workstation -it -P --rm \
		-v ~/.ssh:/root/.ssh \
		-v ~/src:/src \
		-v ~/go:/root/go \
		-w /src \
		$(IMG_NAME)

.PHONY: docker-prune
docker-prune:
	-docker container prune -f
	-docker image prune -f
