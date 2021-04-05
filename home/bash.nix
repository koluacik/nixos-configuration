{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" "ignorespace" ];
    shellAliases = {
      switch-to-dark = "export ALACRITTYTHEME=dark; ~/.config/alacritty/switch-to-dark.sh";
      switch-to-light = "export ALACRITTYTHEME=light; ~/.config/alacritty/switch-to-light.sh";
    };
  };
}
