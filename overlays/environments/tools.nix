self: super:

{
  env-tools = super.pkgs.buildEnv {
    name = "env-tools";
    meta.priority = 0;
    paths = with super.pkgs;
      [
        aria2
        bat
        binutils
        coreutils
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
        mkcert
        neofetch
        pandoc
        pdfcpu
        pup
        pv
        renameutils
        ripgrep
        rlwrap
        sqlite
        tig
        tmux
        toilet
        tree
        unzip
        watch
        ytop
      ] ++ lib.optional (stdenv.isLinux) [
        iotop
        mkpasswd
        pinentry
        utillinux
        wtf
      ];
  };
}
