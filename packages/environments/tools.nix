{ pkgs, ... }:

with pkgs;


pkgs.buildEnv {
  name = "env-tools";
  paths = [
    age
    annie
    aria2
    bat
    binutils
    bottom
    caddy
    conform
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
    git
    github-cli
    gitAndTools.delta
    gitAndTools.hub
    gitAndTools.lefthook
    gnugrep
    gnumake
    gnupg
    gopass
    got
    grafterm
    grpcurl
    gtop
    htop
    imagemagick
    influxdb
    jq
    lastpass-cli
    libfaketime
    loccount
    lsd
    lsof
    maddy
    mark
    mdbook
    mkcert
    mtr
    neofetch
    nmap
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
    s-nail
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
