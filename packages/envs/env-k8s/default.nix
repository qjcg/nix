{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-k8s";
  paths = [
    argo
    argocd
    jg.custom.benthos
    conftest
    jg.newer.cue
    dive
    fly
    jg.custom.k3c
    jg.custom.k3d
    kompose
    kubectl
    kubectx
    kubernetes-helm
    kubeseal
    minio-client
    open-policy-agent
    jg.custom.rancher-cli
    skaffold
    skopeo
    sops
    stern
  ] ++ lib.lists.optionals stdenv.isLinux [ k3s tektoncd-cli ];
  meta = {
    description = "An environment for working with Kubernetes";
    priority = 0;
  };
}
