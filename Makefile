CFG_FILE := configuration.nix

CMD_SWITCH := sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch -I nixos-config=$(CFG_FILE)
# NOTE: darwin-rebuild should NOT be run as root!
CMD_SWITCH_DARWIN := darwin-rebuild switch \
	-I darwin=$(HOME)/.nix-defexpr/channels/darwin \
	-I darwin-config=$(CFG_FILE) \
	-I nixpkgs=$(HOME)/.nix-defexpr/channels/nixpkgs \
	-I home-manager=$(HOME)/.nix-defexpr/channels/home-manager
CMD_SWITCH_HM := home-manager switch -f $(CFG_FILE)


## help: Print usage message for this Makefile.
.PHONY: help
help: Makefile
	@awk -F: '/^## / { gsub("#", ""); printf "%16s : %s\n", $$1, $$2 }' $<

## switch: Run nixos-rebuild switch.
.PHONY: switch
switch:
	$(CMD_SWITCH)

## switch-darwin: Run darwin-rebuild switch.
# NOTE: These commands should NOT be run as root!
.PHONY: switch-darwin
switch-darwin:
	$(CMD_SWITCH_DARWIN)

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

## upgrade-darwin: Run nix-channel --update, then darwin-rebuild switch.
# NOTE: These commands should NOT be run as root!
.PHONY: upgrade-darwin
upgrade-darwin:
	nix-channel --update
	$(CMD_SWITCH_DARWIN)

## repl: Run nix repl and load nixpkgs for debugging.
.PHONY: repl
repl:
	sudo nix repl '<nixpkgs/nixos>'
