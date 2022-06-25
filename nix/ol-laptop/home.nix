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
    pkgs.fzf
    pkgs.gcc
    pkgs.gdb
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

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    withPython3 = true;
    extraPackages = with pkgs; [
      # build dependencies
      gnumake
      gcc
      # formatters
      stylua                                    # lua
      nodePackages.prettier                     # js/ts
      # linters
      nodePackages.eslint_d
      # fuzzy finding
      fd
      # language servers
      sumneko-lua-language-server               # lua
      nodePackages.pyright                      # py
      nodePackages.typescript-language-server   # ts
      nodePackages.vscode-langservers-extracted # html/css/js
      cmake-language-server                     # cmake
      terraform-ls                              # terraform
    ];
    extraPython3Packages = (ps: with ps; [
      debugpy
    ]);
    extraConfig = ''
      luafile $HOME/.config/nvim/lua/nathan-wien/init.lua
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
          vicmd_symbol = "[𝛎](bold green)";
        };
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      james-yu.latex-workshop
      yzhang.markdown-all-in-one
    ];
  };
}
