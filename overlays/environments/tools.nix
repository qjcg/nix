self: super:

{
  env-tools = super.pkgs.buildEnv {
    name = "env-tools";
    meta.priority = 1;
    paths = with super.pkgs;
      [
        age
        aria2
        bat
        binutils
        caddy
        coreutils
        dnsutils
        ed
        fd
        fdupes
        figlet
        file
        findutils
        fortune
        fzf
        getent
        git
        gitAndTools.hub
        gnugrep
        gnumake
        gnupg
        gopass
        htop
        imagemagick
        jq
        lastpass-cli
        lefthook
        libfaketime
        loccount
        lsof
        mdbook
        mkcert
        mtr
        neofetch
        nmap
        pandoc
        pdfcpu
        pup
        pv
        rclone
        renameutils
        restic
        ripgrep
        rlwrap
        rsync
        s-nail
        sqlite
        syncthing
        tig
        tmux
        toilet
        tree
        unzip
        watch
        wireguard-tools
        youtube-dl
        ytop
      ] ++ lib.optional stdenv.isLinux [
        bettercap
        elinks
        iotop
        iw
        mkpasswd
        pinentry
        psmisc
        tailscale
        utillinux
        wtf
      ] ++ lib.optional stdenv.isDarwin [ pstree ];
  };
}
