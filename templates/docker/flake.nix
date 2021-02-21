{
  description = ''
    A flake providing a docker container image.

    Usage:

      # Build the flake's defaultPackage.
      nix build

      # Load the `nix build` result into the local docker cache.
      docker load < result

      # (OPTIONAL) Check whether this flake's defaultPackage builds.
      nix flake check
  '';

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    qjcg.url = "github:qjcg/nix";
  };

  outputs = { self, ... }@inputs:
    inputs.flake-utils.lib.eachSystem [
      "x86_64-linux"
      "aarch64-linux"
    ]
      (system:
        let
          pkgs = import inputs.pkgs {
            inherit system;
            overlays = [ inputs.qjcg.overlay ];
          };
        in
        {
          defaultPackage = with pkgs; dockerTools.buildImage {
            name = "nix-img";
            tag = "latest";
            created = "now";

            contents = [
              busybox
              cacert
              file

              jg.custom.mtlcam
              jg.custom.horeb
            ];

            config = {
              Cmd = [ "/bin/sh" ];
              Env = [
                "PATH=/bin"
                "SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt"
              ];
            };

          };
        });
}
