{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" "ignorespace" ];
    shellAliases = {
      switch-to-dark = "~/.config/alacritty/switch-to-dark.sh";
      switch-to-light = "~/.config/alacritty/switch-to-light.sh";
    };
  };
}
