{ config, pkgs, ... }:

{
  home.file."./.config/xmobar/xmobarrc".source = ./xmobarrc;
  home.file."./.config/xmobar/xmobarrc_0".source = ./xmobarrc_0;
  home.file."./.config/xmobar/xmobarrc_1".source = ./xmobarrc_1;
  home.packages = with pkgs; [
    xmobar
  ];
}

