self: super:

{
  # Overlays from this directory
  neovim = (import ./neovim self super).neovim;
  st = (import ./st self super).st;
  sxiv = (import ./sxiv self super).sxiv;

  # Custom Packages

  go-4d = super.callPackage ../packages/4d {};
  barr = super.callPackage ../packages/barr {};
  battery = super.callPackage ../packages/battery {};
  benthos = super.callPackage ../packages/benthos {};
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
  ludo-bin = super.callPackage ../packages/ludo-bin {};
  mtlcam = super.callPackage ../packages/mtlcam {};
  plan9port = super.callPackage ../packages/plan9port {};
  pms = super.callPackage ../packages/pms {};
  rancher-cli = super.callPackage ../packages/rancher-cli {};
  s-nail = super.callPackage ../packages/s-nail {};
  skaffold = super.callPackage ../packages/skaffold {};


  # Overrides

  delve = super.delve.overrideAttrs (oldAttrs: rec {
    version = "1.4.0";
    src = self.fetchFromGitHub {
      owner = "go-delve";
      repo = "delve";
      rev = "v${version}";
      sha256 = "1db74zw6a5kfjda1mcxqhvs4qcj5cvki2w66f6y0nvw3qgi4c4m4";
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
      #ms-python.python
      ms-vscode-remote.remote-ssh
      redhat.vscode-yaml
      #vscodevim.vim
    ]) ++ super.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "Go";
        publisher = "golang";
        version = "0.14.4";
        sha256 = "1rid3vxm4j64kixlm65jibwgm4gimi9mry04lrgv0pa96q5ya4pi";
      }
      {
        name = "trailing-spaces";
        publisher = "shardulm94";
        version = "0.3.1";
        sha256 = "0h30zmg5rq7cv7kjdr5yzqkkc1bs20d72yz9rjqag32gwf46s8b8";
      }
      {
        name = "remote-containers";
        publisher = "ms-vscode-remote";
        version = "0.116.0";
        sha256 = "1x7fwcajsgp790b5z9f24a7dk169b5b5wn75cybd5w8kk9w8qvxk";
      }
      {
        name = "dotenv";
        publisher = "mikestead";
        version = "1.0.1";
        sha256 = "0rs57csczwx6wrs99c442qpf6vllv2fby37f3a9rhwc8sg6849vn";
      }

      # THEMES

      {
        name = "horizon-vscode";
        publisher = "bauke";
        version = "3.0.2";
        sha256 = "1arrn6y485hz0igzi9hsjn5w1wgq0i85xsadc8fypp646qgqijqz";
      }
      {
        name = "material-icon-theme";
        publisher = "pkief";
        version = "4.1.0";
        sha256 = "00alw214i2iibaqrm1njvb13bb41z3rvgy1akyq8fxvz35vq5a2s";
      }
      {
        name = "winteriscoming";
        publisher = "johnpapa";
        version = "1.4.2";
        sha256 = "0rqmzr6bbaga45idnxbwggb9w578ky4ljx9slvkbc6yibqfskvpl";
      }

    ];
  };

}
