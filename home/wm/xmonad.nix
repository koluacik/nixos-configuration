{ config, pkgs, ... }:

{
  # xsession.enable = true;
  # xsession.windowManager.xmonad = {
  #   # enable = true;
  #   # I do not use xmonad-extras.
  #   # enableContribAndExtras = true;
  #   # config = ./xmonad-conf/Main.hs;
  #   # extraPackages = hp: [
  #   #   hp.xmonad-contrib
  #   # ];
  # };

  home.file."./.config/xmobar/xmobarrc".source = ./xmobarrc;
}
