{ config, pkgs, lib, ... }: with lib; {
  options.myHome.vscode.enable = mkOption { type = types.bool; default = config.myHome.desktop.enable; };

  config = mkIf config.myHome.vscode.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        eamodio.gitlens
        yzhang.markdown-all-in-one
        haskell.haskell
        arrterian.nix-env-selector
        jnoortheen.nix-ide
        justusadam.language-haskell
        mkhl.direnv
        github.github-vscode-theme
        ms-vscode.cpptools
      ];
    };
  };
}
