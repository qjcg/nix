# VSCodium with my preferred extensions.
# Ref: https://nixos.wiki/wiki/VSCodium

# FIXME: The "codium" binary for vscode-with-extensions uses the wrong extensions path (s/share.vscodium/share\/vscode/)
# See `nix edit nixpkgs.vscodium-with-extensions` -> with-extensions.nix /wrappedPkgName..extensions

# NOTE: To work around the fixme issue above, investigating DevContainers as an alternative.
# See https://code.visualstudio.com/docs/remote/containers

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
