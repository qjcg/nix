CFG_FILE := $(HOME)/.config/nixpkgs/configuration.nix

CMD_SWITCH := sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch -I nixos-config=$(CFG_FILE)
# NOTE: darwin-rebuild should NOT be run as root!
CMD_SWITCH_DARWIN := NIX_PATH=darwin-config=$(CFG_FILE):$(HOME)/.nix-defexpr/channels:$(NIX_PATH) darwin-rebuild switch
CMD_SWITCH_HM := home-manager switch -f $(CFG_FILE)


## help: Print usage message for this Makefile.
help: Makefile
	@awk -F: '/^## / { gsub("#", ""); printf "%16s : %s\n", $$1, $$2 }' $<

## switch: Run nixos-rebuild switch.
switch:
	$(CMD_SWITCH)

## switch-darwin: Run darwin-rebuild switch.
# NOTE: These commands should NOT be run as root!
switch-darwin:
	$(CMD_SWITCH_DARWIN)

## switch-hm: Run home-manager switch.
switch-hm:
	$(CMD_SWITCH_HM)

## upgrade: Run nixos-rebuild switch --upgrade.
upgrade:
	$(CMD_SWITCH) --upgrade

SKIP_REGEX := "nodejs"

# Upgrade nix-env environment.
upgrade-env:
	nix-channel --update
	nix-env -q --json | jq -Mr '.[] .pname' | grep -v $(SKIP_REGEX) | xargs nix-env -u

## upgrade-hm: Run nix-channel --update, then home-manager switch.
upgrade-hm:
	nix-channel --update
	$(CMD_SWITCH_HM)

## upgrade-darwin: Run nix-channel --update, then darwin-rebuild switch.
# NOTE: These commands should NOT be run as root!
upgrade-darwin:
	nix-channel --update
	$(CMD_SWITCH_DARWIN)

## repl: Run nix repl and load nixpkgs for debugging.
repl:
	nix repl '<nixpkgs>'
