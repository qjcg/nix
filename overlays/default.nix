self: super:

{
  # FIXME: Import these another way
  #neovim = import ./neovim { inherit self super; };
  #st = import ./st { inherit self super; };
  #sxiv = import ./sxiv { inherit self super; };
  #wayfire = import ./wayfire { inherit self super; };

  # Custom Packages

  go-4d = super.callPackage ../packages/4d {};
  barr = super.callPackage ../packages/barr {};
  battery = super.callPackage ../packages/battery {};
  brightness = super.callPackage ../packages/brightness {};
  cassowary = super.callPackage ../packages/cassowary {};
  emacs = super.callPackage ../packages/emacs {};
  emacs-nox = super.callPackage ../packages/emacs-nox {};
  freetube = super.callPackage ../packages/freetube {};
  gled = super.callPackage ../packages/gled {};
  glooctl = super.callPackage ../packages/glooctl {};
  goplot = super.callPackage ../packages/goplot {};
  hey = super.callPackage ../packages/hey {};
  horeb = super.callPackage ../packages/horeb {};
  jmigpin-editor = super.callPackage ../packages/jmigpin-editor {};
  k3c = super.callPackage ../packages/k3c {};
  k3d = super.callPackage ../packages/k3d {};
  kompose = super.callPackage ../packages/kompose {};
  kubeseal = super.callPackage ../packages/kubeseal {};
  loccount = super.callPackage ../packages/loccount {};
  ludo = super.callPackage ../packages/ludo {};
  mtlcam = super.callPackage ../packages/mtlcam {};
  plan9port = super.callPackage ../packages/plan9port {};
  pms = super.callPackage ../packages/pms {};
  skaffold = super.callPackage ../packages/skaffold {};
  s-nail = super.callPackage ../packages/s-nail {};


  # Overrides

  delve = super.delve.overrideAttrs (oldAttrs: rec {
    version = "1.3.2";
    src = self.fetchFromGitHub {
      owner = "go-delve";
      repo = "delve";
      rev = "v${version}";
      sha256 = "0i2sxr5d4ylakn93lmp65xwhaalbv01q4dih6viwnb9d0gq7p26x";
    };
  });

  dunst = super.dunst.override {
    dunstify = true;
  };

  retroarch = super.retroarch.override {
    cores = with self.libretro; [
      beetle-lynx
      beetle-vb
      dosbox
      fbalpha2012
      fceumm
      genesis-plus-gx
      mame
      mupen64plus
      nestopia
      prboom
      snes9x2010
      stella
    ];
  };

  vscodium-with-extensions = super.vscode-with-extensions.override {
    vscode = super.vscodium;
    vscodeExtensions = (with super.vscode-extensions; [
      bbenoist.Nix
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-azuretools.vscode-docker
      ms-vscode.Go
      #ms-python.python
      redhat.vscode-yaml
      #vscodevim.vim
    ]) ++ super.vscode-utils.extensionsFromVscodeMarketplace [
    ];
  };

}
