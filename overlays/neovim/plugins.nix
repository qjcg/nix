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
