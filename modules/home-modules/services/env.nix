{ config, pkgs, systemFlake, ... }: {
  home.sessionVariables = {
    EDITOR = "kak";
    VISUAL = "kak";
    PROMPT_COMMAND = "history -a; history -n";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIX_SHELL_PRESERVE_PROMPT = "1";
    FZF_DEFAULT_OPTS =
      "--color fg:-1,bg:-1,hl:#268bd2,fg+:#073642,bg+:#eee8d5,hl+:#268bd2 --color info:#b58900,prompt:#b58900,pointer:#002b36,marker:#002b36,spinner:#b58900";
    WINIT_X11_SCALE_FACTOR = "1";
    NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
  };

  xdg.configFile."nix/inputs/nixpkgs".source = systemFlake.inputs.nixpkgs.outPath;
}
