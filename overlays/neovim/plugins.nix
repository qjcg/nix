{ self, super }:

{

  vim-mdx-js = super.pkgs.vimUtils.buildVimPlugin {
    name = "vim-mdx-js";
    src = super.pkgs.fetchFromGitHub {
      owner = "jxnblk";
      repo = "vim-mdx-js";
      rev = "17179d7f2a73172af5f9a8d65b01a3acf12ddd50";
      sha256 = "05j2wd1374328x93ymwfzlcqc9z8sc9qbl63lyy62m291yzh5xn1";
    };
  };

  vim-minimap = super.pkgs.vimUtils.buildVimPlugin {
    name = "vim-minimap";
    src = super.pkgs.fetchFromGitHub {
      owner = "severin-lemaignan";
      repo = "vim-minimap";
      rev = "5a415547e7584eba0bebe087fd553e13c76e8842";
      sha256 = "07q7865bbbq28pf3ijm56qr3wk0xsq0dprhscyjjqjy0jqrgzjra";
    };
  };

  vista.vim = super.pkgs.vimUtils.buildVimPlugin {
    name = "vista.vim";
    src = super.pkgs.fetchFromGitHub {
      owner = "liuchengxu";
      repo = "vista.vim";
      rev = "c1b976faa6c1e0ad6ad70604ff0b8d4b2ce626f7";
      sha256 = "0bfk8bgimlq1b7197n4dya3pa62sbnc9isa1fhlx81x6xf6r8znl";
    };
  };

}
