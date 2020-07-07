# Top-level module.
# See https://nixos.org/nixos/manual/#sec-writing-modules
self: super:

(import ./overlays self super)
