{ config, pkgs, systemFlake, ... }: {
  home.sessionVariables = {
    EDITOR = "kak";
    VISUAL = "kak";
    PROMPT_COMMAND = "history -a; history -n";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIX_SHELL_PRESERVE_PROMPT = "1";
    WINIT_X11_SCALE_FACTOR = "1";
    # NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
  };

  # xdg.configFile."nix/inputs/nixpkgs".source = systemFlake.inputs.nixpkgs.outPath;
}
