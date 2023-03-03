{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nhat";
  home.homeDirectory = "/home/nhat";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # dev
    ansible
    fzf
    gcc
    gdb
    gnumake
    go_1_18
    python310
    stow
    terraform
    tmux
    tmuxp
    tldr
    ripgrep
    # tools
    pandoc
    texlive.combined.scheme-medium
    nixfmt
    # apps
    discord
    obs-studio
    slack
    skypeforlinux
    virtualbox
    zoom-us
    # ui
    pasystray # pulseaudio system tray
    # utilities
    htop
    pavucontrol
    pulseaudio # has to be here, not in configuration.nix; enables pactl
    light # backlight control
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

  # Programs --
  programs.alacritty = { enable = true; };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.gh = {
    enable = true;
    settings = {
      editor = "vim";
      git_protocol = "ssh";
    };
  };

  programs.git = {
    enable = true;
    userName = "nathan-wien";
    userEmail = "nhat.nguyen.cs17@gmail.com";
  };

  programs.i3status-rust = { enable = true; };

  programs.kitty = { enable = true; };

  programs.neovim = import ../programs/neovim.nix { pkgs = pkgs; };
  programs.starship = import ../programs/starship.nix;

  # programs.tmux = {
  #   enable = true;
  # };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ../extra/vim/.vimrc;
  };

  programs.vscode = import ../programs/vscode.nix { pkgs = pkgs; };

  programs.zathura = {
    enable = true;
    # programs.zathura.extraConfig = builtins.readFile ../extra
  };

  programs.zsh = import ../programs/zsh.nix;
}
