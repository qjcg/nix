{ pkgs }:

pkgs.kube3d.override {

  # NOTE: K3s docker images use a "-k3s" suffix, while the k3d repo uses a "+k3d" suffix in git tags.
  # See also https://update.k3s.io/v1-release/channels/stable
  # (version selected here should correspond to the k8s version used in prod)
  k3sVersion = "v1.18.6-k3s1";
}
