{ pkgs, ... }:

with pkgs;


pkgs.buildEnv {
  name = "env-tools";
  paths = [
    age
    jg.custom.annie
    aria2
    bat
    binutils
    bottom
    caddy
    jg.custom.cm
    jg.custom.conform
    coreutils
    croc
    dnsutils
    ed
    jg.overrides.emacs
    exa
    fd
    fdupes
    figlet
    file
    findutils
    fortune
    fzf
    gallery-dl
    getent
    git
    github-cli
    gitAndTools.delta
    gitAndTools.hub
    gitAndTools.lefthook
    gnugrep
    gnumake
    gnupg
    gopass
    jg.custom.got
    jg.custom.grafterm
    grpcurl
    gtop
    htop
    imagemagick
    influxdb
    jq
    lastpass-cli
    libfaketime
    #loccount
    lsd
    lsof
    jg.custom.maddy
    jg.custom.mark
    mdbook
    mkcert
    mtr
    neofetch
    jg.overrides.neovim
    nmap
    nncp
    onefetch
    pandoc
    pdfcpu
    postgresql_12
    pup
    pv
    rclone
    renameutils
    restic
    ripgrep
    rlwrap
    rsync
    ruffle
    jg.custom.s-nail
    shellcheck
    shfmt
    sqlite
    starship
    step-ca
    step-cli
    syncthing
    telegraf
    tig
    tmux
    toilet
    tree
    unzip
    wasmer
    watch
    wireguard-tools
    youtube-dl
    zoxide
  ] ++ lib.lists.optionals stdenv.isLinux [
    bettercap
    bpytop
    elinks
    iotop
    iw
    kapacitor
    mkpasswd
    pinentry
    psmisc
    tailscale
    usbutils
    utillinux
    wtf
  ] ++ lib.lists.optionals stdenv.isDarwin [
    pstree
  ];
  meta = {
    priority = 1;
    description = "An environment providing many generally useful CLI tools";
  };
}
