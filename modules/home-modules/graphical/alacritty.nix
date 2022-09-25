{ config, pkgs, lib, ... }: with lib; {

  options.myHome.alacritty.enable = mkOption { type = types.bool; default = config.myHome.desktop.enable; };

  config = mkIf config.myHome.alacritty.enable {
    home.file."./.config/alacritty/alacritty.yml".source = ../../../home/alacritty/alacritty.yml;
    programs.alacritty.enable = true;
  };
}
