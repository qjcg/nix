# DRW home-manager configuration.
# See https://github.com/rycee/home-manager#usage
{ pkgs, ... }:

{
  home.packages = [
    pkgs.ansible
    pkgs.aria2
    pkgs.cmus
    pkgs.ctags
    pkgs.davmail
    pkgs.dmenu
    pkgs.docker-compose
    pkgs.feh
    pkgs.fzf
    pkgs.gcolor3
    pkgs.go
    pkgs.gtk2fontsel
    pkgs.iosevka
    pkgs.qemu
    pkgs.ripgrep

    # FIXME: Closes immediately on startup.
    pkgs.st
    pkgs.sxiv
    pkgs.tig
    pkgs.zathura
  ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
  };

  home.language = {
    base = "en_US.utf8";
  };

  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    configure = {
      customRC = ''
        colorscheme abstract

        set autochdir
        set hls
        set wildmenu

        autocmd FileType yaml setlocal ai et sw=2 ts=2 cuc
        autocmd FileType nix setlocal cuc
      '';

      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          ansible-vim
          awesome-vim-colorschemes
          fzf-vim
          goyo
          limelight-vim
          neosnippet
          nerdtree
          python-mode
          tagbar
          vim-nix
        ];
      };

    };
  };

  home.keyboard = {
    layout = "us,ca";
    model = "pc105";
    options = "grp:shifts_toggle";
  };

  manual.html.enable = true;

  # FIXME: Won't open, complains about graphics?
  programs.alacritty = {
    enable = true;
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
    ];
  };

  programs.firefox = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.git = {
    enable = true;
    userName = "John Gosset";
    userEmail = "jgosset@drw.com";
  };
}
