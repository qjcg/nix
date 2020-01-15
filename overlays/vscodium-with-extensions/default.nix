# VSCodium with my preferred extensions.
# Ref: https://nixos.wiki/wiki/VSCodium

self: super:

let
  extensions = (with super.vscode-extensions; [
    bbenoist.Nix
    #ms-python.python
  ]) ++ super.vscode-utils.extensionsFromVscodeMarketplace [
  ];

in
  {
    vscodium-with-extensions = super.vscode-with-extensions.override {
      vscode = super.vscodium;
      vscodeExtensions = extensions;
    };
  }
