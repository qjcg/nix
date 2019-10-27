self: super:

let
  customPlugins = {

    vim-mdx-js = super.pkgs.vimUtils.buildVimPlugin {
      name = "vim-mdx-js";
      src = super.pkgs.fetchFromGitHub {
        owner = "jxnblk";
        repo = "vim-mdx-js";
        rev = "17179d7f2a73172af5f9a8d65b01a3acf12ddd50";
        sha256 = "05j2wd1374328x93ymwfzlcqc9z8sc9qbl63lyy62m291yzh5xn1";
      };
    };

  };

  plugins = super.pkgs.vimPlugins // customPlugins;
in
{
  neovim = super.neovim.override {
    viAlias = true;
    vimAlias = true;

    configure = {
      customRC = builtins.readFile ./nvimrc ;
      packages.myVimPackage = with plugins; {

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
