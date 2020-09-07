self: super:

{
  env-k8s = super.pkgs.buildEnv {
    name = "env-k8s";
    meta.priority = 0;
    paths = with super.pkgs; [
      argo
      argocd
      benthos
      conftest
      cue
      dive
      helm
      k3c
      k3d
      kubectl
      kubectx
      kubeseal
      #minio-client
      open-policy-agent
      rancher-cli
      skaffold
      stern
      tekton-cli
    ];
  };
}
