{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" "ignorespace" ];
  };
}
