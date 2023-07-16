{ pkgs, config, lib, ... }:
with lib;
{
  imports = [
    ./extra-confs.nix
    ./xdg.nix
  ];

  options.myHome.desktop.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.myHome.desktop.enable {
    home.packages = with pkgs; [ xmobar dmenu ];
    home.file = {
      "xmobar/xmobarrc_0".source = ../../../xmonad/xmobarrc_0;
      "xmobar/xmobarrc_1".source = ../../../xmonad/xmobarrc_1;
      "xmobar/xmobarrc_2".source = ../../../xmonad/xmobarrc_2;
    };
  };
}

