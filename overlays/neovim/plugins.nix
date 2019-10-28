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

}
