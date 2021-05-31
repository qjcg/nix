{ pkgs, ... }:

with pkgs;


pkgs.buildEnv {
  name = "env-tools";
  paths = [
    age
    jg.custom.annie
    #jg.custom.battery
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
    gforth
    git
    github-cli
    gitAndTools.delta
    gitAndTools.hub
    gnugrep
    gnumake
    gnupg
    gopass
    jg.custom.got
    jg.custom.grafterm
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
    jg.custom.maddy
    jg.custom.mark
    mdbook
    minisign
    mkcert
    mtr
    neofetch
    jg.overrides.neovim
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
