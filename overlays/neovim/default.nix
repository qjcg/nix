self: super:

let
  customPlugins = import ./plugins.nix { inherit self super; };
  allPlugins = super.pkgs.vimPlugins // customPlugins;
in
  {
    neovim = super.neovim.override {
      viAlias = true;
      vimAlias = true;

      configure = {
        customRC = builtins.readFile ./nvimrc ;
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
            #python-mode
            vim-bazel
            vim-beancount
            vim-go
            vim-jsx-pretty
            vim-mdx-js
            vim-minimap
            vim-nix
            vim-orgmode
            vim-pandoc
            vim-pandoc-syntax
            vim-toml
            vista.vim
            yats-vim
          ];

          opt = [ ];
        };      

      };
    };
  }
