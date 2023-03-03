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
    pkgs.cargo
    pkgs.go_1_18
    pkgs.golangci-lint
    pkgs.i3status-rust
    pkgs.texlive.combined.scheme-medium
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
  # programs.bat = {
  #   enable = true;
  #   config = {
  #     theme = "GitHub";
  #   };
  # };
  # programs.exa = {
  #   enable = true;
  #   enableAliases = true;
  # };
  # programs.neovim = import ../programs/neovim.nix { pkgs = pkgs; };
  programs.starship = import ../programs/starship.nix;
  # programs.vscode = import ../programs/vscode.nix { pkgs = pkgs; };
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    envExtra = ''
      # export {http,https,ftp}_proxy=http://www-proxy-syd.au.oracle.com:80
      # export no_proxy='localhost,127.0.0.1,*.zoom.us,::1,192.168.0.0/16,10.0.0.0/8,.oracle.com,.oraclecorp.com,.oraclevcn.com,.oraclevpn.com'

      export XDG_CONFIG_HOME="$HOME/.config"

      # java
      export JAVA_HOME="$(dirname $(dirname $(readlink -f /usr/bin/java)))"
      export PATH="$JAVA_HOME/bin:$PATH"

      alias switchjava="sudo update-alternatives --config java"

      # pip
      export PATH="$HOME/.local/bin:$PATH"

      # go
      export PATH="$(go env GOPATH)/bin:$PATH"

      # cargo
      export PATH="$HOME/.cargo/bin:$PATH"

      # nvim
      export PATH="$HOME/bin/nvim/bin:$PATH"

      # vivid colors
      export LS_COLORS="$(vivid -m 8-bit generate one-light)"

      # vi mode
      bindkey -v
      bindkey '^Y' forward-char

      # cht.sh
      export CHTSH_CONF="$XDG_CONFIG_HOME/cht.sh/cht.sh.conf"
    ''
    ;
  };
}
