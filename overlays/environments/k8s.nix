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
    ];
  };
}
