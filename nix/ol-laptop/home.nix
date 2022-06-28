{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "minhnngu";
  home.homeDirectory = "/home/minhnngu";

  # Packages that should be installed to the user profile.
  nixpkgs.config.allowUnfree = true;

  # nixpkgs.overlays = [
  #   # neovim nightly
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #   }))
  # ];

  home.packages = [
    # dev
    pkgs.ansible
    pkgs.cargo
    pkgs.cmake
    pkgs.docker
    pkgs.docker-compose
    pkgs.fzf
    pkgs.go_1_18
    pkgs.i3status-rust
    pkgs.python310
    pkgs.stow
    pkgs.terraform
    pkgs.tmux
    pkgs.tmuxp
    pkgs.tldr
    pkgs.ripgrep
    # tools
    pkgs.bitwarden-cli
    pkgs.pandoc
    pkgs.texlive.combined.scheme-medium
    # pkgs.zathura
    # apps
    # pkgs.alacritty
    # pkgs.discord
    # pkgs.mendeley
    # pkgs.obs-studio
    # pkgs.slack
    # pkgs.skypeforlinux
    # pkgs.virtualbox
    # pkgs.vscode
    # pkgs.zoom-us
    # ui
    # pkgs.pasystray # pulseaudio system tray
    # utilities
    pkgs.htop
    # pkgs.pavucontrol
    # pkgs.pulseaudio # has to be here, not in configuration.nix; enables pactl
    # pkgs.light      # backlight control
    # font
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Programs
  programs.exa = {
    enable = true;
    enableAliases = true;
  };
  programs.neovim = import ../programs/neovim.nix { pkgs = pkgs; };
  programs.starship = import ../programs/starship.nix;
  programs.vscode = import ../programs/vscode.nix { pkgs = pkgs; };
}
