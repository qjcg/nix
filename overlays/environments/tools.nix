self: super:

{
  env-tools = super.pkgs.buildEnv {
    name = "env-tools";
    meta.priority = 1;
    paths = with super.pkgs;
      [
        aria2
        bat
        binutils
        caddy
        coreutils
        dnsutils
        ed
        elinks
        fd
        fdupes
        figlet
        file
        fortune
        fzf
        git
        gitAndTools.hub
        gnumake
        gnupg
        gopass
        htop
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
      ] ++ lib.optional (stdenv.isLinux) [
        bettercap
        iotop
        iw
        mkpasswd
        pinentry
        tailscale
        utillinux
        wtf
      ];
  };
}
