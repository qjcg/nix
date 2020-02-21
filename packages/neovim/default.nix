self: super:

let
  # Nixpkgs for neovim.
  # See https://hydra.nixos.org/job/nixos/trunk-combined/nixpkgs.neovim-unwrapped.x86_64-linux
  nixpkgs_neovim =
    (import (builtins.fetchGit {
      # Descriptive name to make the store path easier to identify
      name = "nixpkgs_neovim";
      url = https://github.com/nixos/nixpkgs/;
      rev = "91fb0f2e4710d6a2f5e5cc55197afcddbd490c33";
    }) {});

  customPlugins = import ./plugins.nix { inherit self super; };
  allPlugins = super.pkgs.vimPlugins // customPlugins;

  # Concatenate all modular nvim config files from ./init.vim.d
  nvimConfigPaths = map(f: "/" + f) (builtins.attrNames (builtins.readDir ./init.vim.d));
  nvimConfig = super.lib.concatStrings (map(f: builtins.readFile (./init.vim.d + f)) nvimConfigPaths);
in
  {
    neovim = nixpkgs_neovim.neovim.override {
      viAlias = true;
      vimAlias = true;

      configure = {
        customRC = nvimConfig ;
        packages.myVimPackage = with allPlugins; {

          start = [
            ansible-vim
            awesome-vim-colorschemes
            changeColorScheme-vim

            ## FIXME: These COC plugins are DISABLED for now, pending resolution of: https://github.com/NixOS/nixpkgs/issues/64560
            ## For now, my workaround has been to install each of these individually via ex: `:CocInstall coc-css`.
            ## Extentions are installed into ~/.config/coc/extensions/package.json
            ## To review available extensions, do:
            ## - `:CocInstall coc-marketplace`
            ## - `:CocList marketplace`
            #coc-css
            #coc-git
            #coc-go
            #coc-highlight
            #coc-html
            #coc-json
            coc-nvim
            #coc-prettier
            #coc-python
            #coc-snippets
            #coc-tslint-plugin
            #coc-tsserver
            #coc-yaml

            fzf-vim
            goyo
            limelight-vim
            nerdtree
            vim-bazel
            vim-beancount
            vim-cue
            vim-go
            vim-jsx-pretty
            vim-mdx-js
            vim-nix
            vim-orgmode
            vim-pandoc-syntax
            vim-toml
            vista.vim
            xonsh-vim
            yats-vim
          ];

          opt = [ ];
        };      

      };
    };
  }
