{ config, pkgs, lib, ... }: with lib; {

  options.myHome.alacritty.enable = mkOption { type = types.bool; default = config.myHome.desktop.enable; };

  config = mkIf config.myHome.alacritty.enable {
    home.file."./.config/alacritty/alacritty.toml".source = ../../../home/alacritty/alacritty.toml;
    programs.alacritty.enable = true;
  };
}
