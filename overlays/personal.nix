# Packages for my own software.

self: super:

{
    barr = super.callPackage ../packages/barr {};
    mtlcam = super.callPackage ../packages/mtlcam {};
    horeb = super.callPackage ../packages/horeb {};
}
