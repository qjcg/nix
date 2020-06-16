# nix-darwin programs (system-wide).

{
  programs = {

    # Create /etc/bashrc that loads the nix-darwin environment.
    bash.enable = true;

    # Completion does NOT work with default version of bash (v3) on macOS.
    bash.enableCompletion = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    tmux = {
      enable = true;
      defaultCommand = "xonsh -l";
      extraConfig = builtins.readFile ../../files/tmux.conf;
    };
  };
}
