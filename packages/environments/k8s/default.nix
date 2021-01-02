{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-k8s";
  paths = [
    argo
    argocd
    benthos
    conftest
    cue
    dive
    fly
    #helm
    k3c
    k3d
    kompose
    kubectl
    kubectx
    kubeseal
    #minio-client
    open-policy-agent
    rancher-cli
    skaffold
    sops
    stern
    tekton-cli
  ] ++ lib.lists.optionals stdenv.isLinux [ k3s ];
  meta = {
    description = "An environment for working with Kubernetes";
    priority = 0;
  };
}