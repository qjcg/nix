# Packages for my own software.

self: super:

{
    go-4d = super.callPackage ../packages/4d {};
    barr = super.callPackage ../packages/barr {};
    mtlcam = super.callPackage ../packages/mtlcam {};
    horeb = super.callPackage ../packages/horeb {};
}
