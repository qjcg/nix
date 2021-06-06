{ pkgs, ... }:

let
  inherit (builtins) getFlake;
  inherit (pkgs) buildEnv;
  inherit (pkgs.lib.lists) optionals;
  inherit (pkgs.stdenv) isLinux;
in
buildEnv {
  name = "env-k8s";
  paths = with pkgs; [
    jg.custom.benthos
    jg.custom.blox
    jg.custom.container-structure-test
    jg.custom.go-internal
    jg.custom.k3c
    jg.custom.rancher-cli
    jg.custom.unity
    jg.overrides.kube3d

    argo
    argocd
    conftest
    cue
    dive
    fly
    kompose
    kubectl
    kubectx
    kubernetes-helm
    kubeseal
    minio-client
    open-policy-agent
    skaffold
    skopeo
    sops
    stern
  ] ++ optionals isLinux [ k3s tektoncd-cli ];
  meta = {
    description = "An environment for working with Kubernetes";
    priority = 0;
  };
}
