super:

{
  janet.vim = super.pkgs.vimUtils.buildVimPlugin {
    name = "janet.vim";
    src = super.pkgs.fetchFromGitHub {
      owner = "janet-lang";
      repo = "janet.vim";
      rev = "60926ca06bda6e4c8fa7daccd5c224d504ab4afe";
      sha256 = "04y6q8wyax5m8kvibqlrymv6k0f25gcihrrn6vx35akg7mvjkdg0";
    };
  };

  vim-cue = super.pkgs.vimUtils.buildVimPlugin {
    name = "vim-cue";
    src = super.pkgs.fetchFromGitHub {
      owner = "jjo";
      repo = "vim-cue";
      rev = "8338fb7642976ead40d3eec53e17ba025c67ed2e";
      sha256 = "1rgw9drbwshj310azypf4wkvl2m4s5c79w3niygpgz6ysd70rq8v";
    };
  };

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

  xonsh-vim = super.pkgs.vimUtils.buildVimPlugin {
    name = "xonsh-vim";
    src = super.pkgs.fetchFromGitHub {
      owner = "linkinpark342";
      repo = "xonsh-vim";
      rev = "984a7e8cf5f2516976667c34d6cb61bd01f93be0";
      sha256 = "052r678mh3cg8dc1ghv0gp459pddnzxvmgmdp6y5085rhib191d5";
    };
  };

}
