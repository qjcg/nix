IMG_NAME := nix-workstation
CFG_FILE := configuration.nix
CMD_SWITCH := sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch -I nixos-config=$(CFG_FILE)
CMD_SWITCH_HM := home-manager switch -f $(CFG_FILE)


## help: Print usage message for this Makefile.
.PHONY: help
help: Makefile
	@awk -F: '/^## / { gsub("#", ""); printf "%20s : %s\n", $$1, $$2 }' $<

## switch: Run nixos-rebuild switch.
.PHONY: switch
switch:
	$(CMD_SWITCH)

## switch-hm: Run home-manager switch.
.PHONY: switch-hm
switch-hm:
	$(CMD_SWITCH_HM)

## upgrade: Run nixos-rebuild switch --upgrade.
.PHONY: upgrade
upgrade:
	$(CMD_SWITCH) --upgrade

## upgrade-hm: Run nix-channel --update, then home-manager switch.
.PHONY: upgrade-hm
upgrade-hm:
	nix-channel --update
	$(CMD_SWITCH_HM)

## repl: Run nix repl and load nixpkgs for debugging.
.PHONY: repl
repl:
	sudo nix repl '<nixpkgs/nixos>'


## docker-build: Build a container image using the Dockerfile.
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

## docker-prune: Prune docker containers and images.
.PHONY: docker-prune
docker-prune:
	-docker container prune -f
	-docker image prune -f
