self: super:

let
  customPlugins = import ./plugins.nix {inherit self super; };
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
            coc-css
            coc-git
            coc-go
            coc-highlight
            coc-html
            coc-json
            coc-nvim
            coc-prettier
            coc-python
            coc-snippets
            coc-yaml
            fzf-vim
            goyo
            limelight-vim
            nerdtree
            #python-mode
            tagbar
            vim-beancount
            vim-go
            vim-jsx-pretty
            vim-mdx-js
            vim-nix
            vim-pandoc
            vim-pandoc-syntax
            vim-toml
          ];

          opt = [ ];
        };      

      };
    };
  }
