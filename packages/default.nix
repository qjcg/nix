self: super:

{
  # Packages.
  go-4d = super.callPackage ./4d {};
  barr = super.callPackage ./barr {};
  battery = super.callPackage ./battery {};
  brightness = super.callPackage ./brightness {};
  cassowary = super.callPackage ./cassowary {};
  emacs = super.callPackage ./emacs {};
  emacs-nox = super.callPackage ./emacs-nox {};
  freetube = super.callPackage ./freetube {};
  gled = super.callPackage ./gled {};
  glooctl = super.callPackage ./glooctl {};
  goplot = super.callPackage ./goplot {};
  hey = super.callPackage ./hey {};
  horeb = super.callPackage ./horeb {};
  jmigpin-editor = super.callPackage ./jmigpin-editor {};
  k3c = super.callPackage ./k3c {};
  k3d = super.callPackage ./k3d {};
  kompose = super.callPackage ./kompose {};
  kubeseal = super.callPackage ./kubeseal {};
  loccount = super.callPackage ./loccount {};
  ludo = super.callPackage ./ludo {};
  mtlcam = super.callPackage ./mtlcam {};
  plan9port = super.callPackage ./plan9port {};
  pms = super.callPackage ./pms {};
  skaffold = super.callPackage ./skaffold {};
  s-nail = super.callPackage ./s-nail {};
  wayfire = super.callPackage ./wayfire {};
}
