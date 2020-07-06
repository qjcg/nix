self: super:

{
  env-k8s = super.pkgs.buildEnv {
    name = "env-k8s";
    meta.priority = 0;
    paths = with super.pkgs; [
      argo
      argocd
      benthos
      dive
      helm
      k3c
      k3d
      kubectl
      kubectx
      kubeseal
      rancher-cli
      skaffold
      stern
      tekton-cli
    ];
  };
}
