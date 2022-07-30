{ pkgs, ... }: {
  enable = true;
  package = pkgs.neovim-nightly;
  withPython3 = true;
  extraPackages = with pkgs; [
    # build dependencies
    gnumake
    gcc
    # formatters
    stylua # lua
    nodePackages.prettier # js/ts
    # linters
    nodePackages.eslint_d
    # fuzzy finding
    fd
    # language servers
    sumneko-lua-language-server # lua
    # nodePackages.pyright # py
    # nodePackages.typescript-language-server # ts
    # nodePackages.vscode-langservers-extracted # html/css/js
    # nodePackages.yaml-language-server # yaml
    # cmake-language-server # cmake
    # terraform-ls # terraform
  ];
  extraPython3Packages = (ps: with ps; [ debugpy ]);
  extraConfig = ''
    luafile $HOME/.config/nvim/lua/nathan-wien/init.lua
  '';
}
