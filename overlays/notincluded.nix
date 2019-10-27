# Packages for 3rd-party packages not currently included in nixpkgs.

self: super:

{
    goplot = super.callPackage ../packages/goplot {};
    k3d = super.callPackage ../packages/k3d {};
    loccount = super.callPackage ../packages/loccount {};
    s-nail = super.callPackage ../packages/s-nail {};
}
