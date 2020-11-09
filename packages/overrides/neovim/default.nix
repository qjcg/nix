{ pkgs, ... }:
let
  customPlugins = import ./plugins.nix pkgs;
  allPlugins = pkgs.vimPlugins // customPlugins;

  # Concatenate all modular nvim config files from ./init.vim.d
  nvimConfigPaths =
    map (f: "/" + f) (builtins.attrNames (builtins.readDir ./init.vim.d));
  nvimConfig = pkgs.lib.concatStrings
    (map (f: builtins.readFile (./init.vim.d + f)) nvimConfigPaths);
in
pkgs.neovim.override {
  viAlias = true;
  vimAlias = true;

  configure = {
    customRC = nvimConfig;
    packages.myVimPackage = with allPlugins; {

      start = [
        ansible-vim
        awesome-vim-colorschemes
        changeColorScheme-vim
        direnv-vim

        ## Uses coc-nvim.
        ##
        ## See:
        ##   - http://blog.coolshark.xyz/2019/12/coc-plugin/
        ##
        ## Non-nix-installed extentions are installed into ~/.config/coc/extensions/package.json
        ## To review these, do:
        ## - `:CocInstall coc-marketplace`
        ## - `:CocList marketplace`
        ##
        ## NOTE: The coc-nvim plugin MUST come before other coc- plugins!
        ## See https://github.com/NixOS/nixpkgs/issues/64560#issuecomment-613968827
        coc-nvim
        coc-css
        coc-go
        coc-html
        coc-json
        coc-markdownlint
        coc-prettier
        coc-python
        coc-snippets
        coc-tsserver
        coc-vimlsp
        coc-yaml

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
}
