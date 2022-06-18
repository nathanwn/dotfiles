{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nhat";
  home.homeDirectory = "/home/nhat";

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.ansible
    pkgs.fzf
    pkgs.gcc
    pkgs.gdb
    pkgs.go_1_18
    pkgs.htop
    pkgs.stow
    pkgs.tmuxp
    pkgs.tldr
    pkgs.ripgrep
    pkgs.python310
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
  programs.alacritty = {
    enable = true;
    # settings = {
    #   font_family = "JetBrainsMono Nerd Font";
    # };
  };

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

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    withPython3 = true;
    extraPackages = with pkgs; [
      # formatters
      stylua                                    # lua
      nodePackages.prettier                     # js/ts
      # linters
      nodePackages.eslint_d
      # language servers
      sumneko-lua-language-server               # lua
      nodePackages.pyright                      # py
      nodePackages.typescript-language-server   # ts
      nodePackages.vscode-langservers-extracted # html/css/js
    ];
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

  programs.tmux = {
    enable = true;
    prefix = "C-a";
  };

  programs.vscode = {
    enable = true;
  };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ../extra/vim/.vimrc;
  };

  programs.zathura = {
    enable = true;
    # programs.zathura.extraConfig = builtins.readFile ../extra
  };

  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    envExtra = ''
      bindkey -v
      export LIBGL_ALWAYS_SOFTWARE=1
    '';
  };
}
