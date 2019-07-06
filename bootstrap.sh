#!/usr/bin/env bash
# Set up home-manager.

mkdir -m 0755 -p /nix/var/nix/{profiles,gcroots}/per-user/$USER

nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-env -i home-manager
