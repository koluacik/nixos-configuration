{ config, pkgs, ... }:

{
  xsession.enable = true;
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = readFile ./xmonad-conf/Main.hs;
  };
}
