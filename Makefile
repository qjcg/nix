CFG_FILE := $(abspath configuration.nix)
OPTS := NIXPKGS_ALLOW_UNFREE=1
KERNEL := $(shell uname)

# Set commands according to OS kernel.
ifeq ($(KERNEL),Linux)
  # NixOS
  CMD_SWITCH := sudo $(OPTS) nixos-rebuild switch -I nixos-config=$(CFG_FILE)
else ifeq ($(KERNEL),Darwin)
  # NOTE: darwin-rebuild should NOT be run as root!
  CMD_SWITCH := $(OPTS) NIX_PATH=darwin-config=$(CFG_FILE):$(HOME)/.nix-defexpr/channels:$(NIX_PATH) darwin-rebuild switch --show-trace
else
  $(error Unknown OS kernel, exiting!)
endif

switch:
	$(CMD_SWITCH)

update-switch:
	nix-channel --update
	sudo nix-channel --update
	$(CMD_SWITCH)


# CONTAINER

.PHONY: container container-login clean
CONTAINER_NAME := test123

container:
	sudo nixos-container create $(CONTAINER_NAME) --flake '.#test'
	sudo nixos-container start $(CONTAINER_NAME)

container-login:
	sudo nixos-container root-login $(CONTAINER_NAME)

clean:
	sudo nixos-container destroy test123
