self: super:

let
  customPlugins = import ./plugins.nix super;
  allPlugins = super.pkgs.vimPlugins // customPlugins;

  # Concatenate all modular nvim config files from ./init.vim.d
  nvimConfigPaths = map(f: "/" + f) (builtins.attrNames (builtins.readDir ./init.vim.d));
  nvimConfig = super.lib.concatStrings (map(f: builtins.readFile (./init.vim.d + f)) nvimConfigPaths);
in
  {
    neovim = super.neovim.override {
      viAlias = true;
      vimAlias = true;

      configure = {
        customRC = nvimConfig ;
        packages.myVimPackage = with allPlugins; {

          start = [
            ansible-vim
            awesome-vim-colorschemes
            changeColorScheme-vim
            direnv-vim

            ## Non-nix-installed extentions are installed into ~/.config/coc/extensions/package.json
            ## To review these, do:
            ## - `:CocInstall coc-marketplace`
            ## - `:CocList marketplace`
            ##
            ## NOTE: The coc-nvim plugin MUST come before other coc- plugins!
            ## See https://github.com/NixOS/nixpkgs/issues/64560#issuecomment-613968827
            coc-nvim
            #coc-go  # FIXME: Error on startup about missing main file "lib/extension.js" (see package.json).
            coc-prettier
            coc-snippets
            coc-tsserver

            fzf-vim
            goyo

            # FIXME: Seems to need janet executable as a buildInput.
            #janet.vim

            limelight-vim
            nerdtree
            vim-beancount
            vim-cue
            vim-go
            vim-jsx-pretty
            vim-mdx-js
            vim-nix
            vim-orgmode
            vim-pandoc-syntax
            vim-prisma
            vim-toml
            xonsh-vim
            yats-vim
          ];

          opt = [ ];
        };      

      };
    };
  }
