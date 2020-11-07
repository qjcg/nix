{ pkgs }:

{
  vscodium-with-extensions = pkgs.vscode-with-extensions.override {
    vscode = pkgs.vscodium;
    vscodeExtensions = (with pkgs.vscode-extensions; [
      bbenoist.Nix
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-azuretools.vscode-docker
      #ms-python.python
      ms-vscode-remote.remote-ssh
      redhat.vscode-yaml
      #vscodevim.vim
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
