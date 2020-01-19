# VSCodium with my preferred extensions.
# Ref: https://nixos.wiki/wiki/VSCodium

# FIXME: The "codium" binary for vscode-with-extensions uses the wrong extensions path (s/share.vscodium/share\/vscode/)
# See `nix edit nixpkgs.vscodium-with-extensions` -> with-extensions.nix /wrappedPkgName..extensions

self: super:

let
  extensions = (with super.vscode-extensions; [
    bbenoist.Nix
    ms-kubernetes-tools.vscode-kubernetes-tools
    ms-azuretools.vscode-docker
    ms-vscode.Go
    #ms-python.python
    redhat.vscode-yaml
    #vscodevim.vim
  ]) ++ super.vscode-utils.extensionsFromVscodeMarketplace [
  ];

in
  {
    vscodium-with-extensions = super.vscode-with-extensions.override {
      vscode = super.vscodium;
      vscodeExtensions = extensions;
    };
  }
