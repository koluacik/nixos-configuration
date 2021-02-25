{ config, pkgs, ... }:

{
  xsession.enable = true;
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad-conf/Main.hs;
    extraPackages = hp: [
      hp.taffybar
    ];
  };

  home.file."./.config/xmobar/xmobarrc".source = ./xmobarrc;
}
