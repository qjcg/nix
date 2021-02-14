KERNEL := $(shell uname)

# Set commands according to OS kernel.
ifeq ($(KERNEL),Linux)
  # NixOS
  CMD_SWITCH := sudo nixos-rebuild switch --flake .
else ifeq ($(KERNEL),Darwin)
  # NOTE: darwin-rebuild should NOT be run as root!
  CMD_SWITCH := darwin-rebuild switch --flake .
else
  $(error Unknown OS kernel, exiting!)
endif

switch:
	$(CMD_SWITCH)

# Launch the nix REPL for troubleshooting & debugging.
repl:
	nix repl ./lib/default.nix


# NIXOS-CONTAINER (linux only)

CONTAINER_NAME := wrkc

container:
	$(shell sudo nixos-container create $(CONTAINER_NAME) --flake '.#$(CONTAINER_NAME)' || sudo nixos-container update $(CONTAINER_NAME) --flake '.#$(CONTAINER_NAME)')
	sudo nixos-container start $(CONTAINER_NAME)
	sudo nixos-container root-login $(CONTAINER_NAME)

clean-container:
	sudo nixos-container destroy $(CONTAINER_NAME)


# NIXOS-VM (linux only)
vm:
	nixos-rebuild build-vm --flake .#workstationVM
	QEMU_OPTS="-vga virtio -display gtk,gl=on -m 8G -smp 2" ./result/bin/run-nixos-vm

clean-vm:
	rm -f result *.qcow2
