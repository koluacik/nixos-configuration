{ config, pkgs, ... }:

{
  home.file."./.config/xmobar/xmobarrc".source = ./xmobarrc;
}
