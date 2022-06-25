{ pkgs, ... }: {
  enable = true;
  extensions = with pkgs.vscode-extensions; [
    james-yu.latex-workshop
    yzhang.markdown-all-in-one
  ];
}
