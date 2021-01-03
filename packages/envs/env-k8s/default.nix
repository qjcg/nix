{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-k8s";
  paths = [
    argo
    argocd
    jg.custom.benthos
    conftest
    cue
    dive
    fly
    #helm
    jg.custom.k3c
    k3d
    kompose
    kubectl
    kubectx
    kubeseal
    #minio-client
    open-policy-agent
    jg.custom.rancher-cli
    skaffold
    sops
    stern
    jg.custom.tekton-cli
  ] ++ lib.lists.optionals stdenv.isLinux [ k3s ];
  meta = {
    description = "An environment for working with Kubernetes";
    priority = 0;
  };
}
