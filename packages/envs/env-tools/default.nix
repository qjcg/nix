{ pkgs, ... }:

with pkgs;


pkgs.buildEnv {
  name = "env-tools";
  paths = [
    jg.custom.annie
    #jg.custom.battery
    jg.custom.cm
    jg.custom.conform
    jg.custom.got
    jg.custom.grafterm
    jg.custom.mark
    #jg.custom.s-nail
    jg.overrides.emacs
    jg.overrides.neovim

    age
    aria2
    bat
    binutils
    bottom
    caddy
    coreutils
    croc
    dnsutils
    ed
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
    gforth
    git
    github-cli
    gitAndTools.delta
    gitAndTools.hub
    gnugrep
    gnumake
    gnupg
    gopass
    grpcurl
    gtop
    hey
    htop
    imagemagick
    influxdb
    innernet
    jq
    lastpass-cli
    lefthook
    libfaketime
    #loccount
    lsd
    lsof
    maddy
    mdbook
    minisign
    mkcert
    mtr
    neofetch
    nfpm
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
    ruffle
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
