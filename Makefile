IMG_NAME := nix-workstation
CFG_FILE := configuration.nix
CMD_SWITCH := sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch -I nixos-config=$(CFG_FILE)
CMD_SWITCH_HM := home-manager switch -f $(CFG_FILE)


.PHONY: switch
switch:
	$(CMD_SWITCH)

.PHONY: switch-hm
switch-hm:
	$(CMD_SWITCH_HM)

.PHONY: upgrade
upgrade:
	$(CMD_SWITCH) --upgrade

.PHONY: upgrade-hm
upgrade-hm:
	nix-channel --update
	$(CMD_SWITCH_HM)

.PHONY: repl
repl:
	sudo nix repl '<nixpkgs/nixos>'


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
