{ config, pkgs, ... }:

{
  xsession.enable = true;
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad-conf/Main.hs;
  };
}
