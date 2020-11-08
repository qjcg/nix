final: prev:

{
  janet.vim = prev.vimUtils.buildVimPlugin {
    name = "janet.vim";
    src = prev.fetchFromGitHub {
      owner = "janet-lang";
      repo = "janet.vim";
      rev = "60926ca06bda6e4c8fa7daccd5c224d504ab4afe";
      sha256 = "04y6q8wyax5m8kvibqlrymv6k0f25gcihrrn6vx35akg7mvjkdg0";
    };
  };

  vim-cue = prev.vimUtils.buildVimPlugin {
    name = "vim-cue";
    src = prev.fetchFromGitHub {
      owner = "jjo";
      repo = "vim-cue";
      rev = "1c802d17f86c775d879b2cdebe84efd40dc4bbfd";
      sha256 = "1gp0s4094prxqyzk39igigjqppha7bmy4j36wxl16ns1v8yq4qp1";
    };
  };

  vim-mdx-js = prev.vimUtils.buildVimPlugin {
    name = "vim-mdx-js";
    src = prev.fetchFromGitHub {
      owner = "jxnblk";
      repo = "vim-mdx-js";
      rev = "17179d7f2a73172af5f9a8d65b01a3acf12ddd50";
      sha256 = "05j2wd1374328x93ymwfzlcqc9z8sc9qbl63lyy62m291yzh5xn1";
    };
  };

  vim-prisma = prev.vimUtils.buildVimPlugin {
    name = "vim-prisma";
    src = prev.fetchFromGitHub {
      owner = "pantharshit00";
      repo = "vim-prisma";
      rev = "e91ac5011232e1bd8ea53204db8d01203d5d0f3c";
      sha256 = "0pc203n70g1b0qfvrnfi5sxg2vr9zfw274s9lpgpxmribknpxi86";
    };
  };

  xonsh-vim = prev.vimUtils.buildVimPlugin {
    name = "xonsh-vim";
    src = prev.fetchFromGitHub {
      owner = "linkinpark342";
      repo = "xonsh-vim";
      rev = "984a7e8cf5f2516976667c34d6cb61bd01f93be0";
      sha256 = "052r678mh3cg8dc1ghv0gp459pddnzxvmgmdp6y5085rhib191d5";
    };
  };

}
