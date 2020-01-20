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
    glooctl = super.callPackage ./glooctl {};
    goplot = super.callPackage ./goplot {};
    hey = super.callPackage ./hey {};
    horeb = super.callPackage ./horeb {};
    k3d = super.callPackage ./k3d {};
    kompose = super.callPackage ./kompose {};
    loccount = super.callPackage ./loccount {};
    ludo = super.callPackage ./ludo {};
    mtlcam = super.callPackage ./mtlcam {};

    #neovim = super.callPackage ./neovim {inherit self super; };

    skaffold = super.callPackage ./skaffold {};
    s-nail = super.callPackage ./s-nail {};
    st = super.callPackage ./st {};
    sxiv = super.callPackage ./sxiv {};
    vscodium-with-extensions = super.callPackage ./vscodium-with-extensions {};
}
