{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = { today = "date +%F"; };
    historyControl = [ "erasedups" "ignorespace" ];
    bashrcExtra = builtins.readFile ./bashrc;
  };
}
