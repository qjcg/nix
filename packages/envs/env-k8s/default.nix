{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-k8s";
  paths = [
    jg.custom.benthos
    jg.custom.blox
    jg.custom.container-structure-test
    jg.custom.go-internal
    jg.custom.k3c
    jg.custom.k3d
    jg.custom.rancher-cli
    jg.custom.unity
    jg.newer.cue

    argo
    argocd
    conftest
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
  ] ++ lib.lists.optionals stdenv.isLinux [ k3s tektoncd-cli ];
  meta = {
    description = "An environment for working with Kubernetes";
    priority = 0;
  };
}
