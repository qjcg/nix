{ config, pkgs, ... }:

{
  environment = {

    # Use a custom configuration.nix location.
    # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
    darwinConfig = "$HOME/.config/nixpkgs/machines/darwin/configuration.nix";

    shellAliases = {
      ls = "ls --color --group-directories-first";
      k = "kubectl";
    };

    shells = with pkgs; [
      bashInteractive_5
    ];

    systemPackages = with pkgs; [
      bashInteractive_5
      getent
      #env-mac
    ];

    variables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
    };
  };

  programs = {
    # Create /etc/bashrc that loads the nix-darwin environment.
    bash.enable = true;

    # Completion does NOT work with default version of bash (v3) on macOS.
    #bash.enableCompletion = true;

    tmux = {
      enable = true;
      tmuxConfig = ''
        set -g renumber-windows on
        set -g set-titles on
        set -g set-titles-string "tmux: #H/#S/#W"

        set-option -sa terminal-overrides ',xterm-256color:RGB'

        set -g status-left "[#H/#S] "
        set -g status-left-length 25
        set -g status-right ""
        set -g status-right-length 25
        set -g status-justify left
        set -g message-style                 "fg=green bright"
        set -g status-style                  "fg=white dim"
        setw -g window-status-style	     "fg=white dim"
        setw -g window-status-current-style  "fg=cyan  dim"

        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"

        bind C command-prompt -p "New session name:" "new-session -s %1"
        bind R source-file /etc/tmux.conf \; display-message "source-file /etc/tmux.conf"
        bind < command-prompt -p "Rename session to:" "rename-session %%"
        bind > choose-tree "move-window -t %%"

        bind -r M-Left previous-window
        bind -r M-Right next-window

        #bind -r C-Left previous-session
        #bind -r C-Right next-session

        set-option -sg escape-time 10
        set-option -g default-terminal "screen-256color"
      '';
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  time.timeZone = "America/Montreal";

  nix = {
    package = pkgs.nix;

    # You should generally set this to the total number of logical cores in your system.
    # $ sysctl -n hw.ncpu
    maxJobs = 8;
    buildCores = 0;
  };

  nixpkgs.overlays = [
    #import ../../overlays/environments.nix
  ];

}
