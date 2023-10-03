{ config, pkgs, lib, ... }: with lib; {
  options.myHome.vscode.enable = mkOption { type = types.bool; default = config.myHome.desktop.enable; };

  config = mkIf config.myHome.vscode.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        eamodio.gitlens

        yzhang.markdown-all-in-one

        haskell.haskell
        justusadam.language-haskell

        jnoortheen.nix-ide
        mkhl.direnv

        ms-vscode.cpptools
        vadimcn.vscode-lldb

        tamasfe.even-better-toml
        mechatroner.rainbow-csv
      ];
    };
  };
}
