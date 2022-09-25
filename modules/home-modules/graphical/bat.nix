{ config, pkgs, lib, ... }: with lib; {

  options.myHome.bat.enable = mkOption { type = types.bool; default = config.myHome.desktop.enable; };

  config = mkIf config.myHome.bat.enable {
    programs.bat.enable = true;
    programs.bat.config.theme = "Solarized (light)";
  };
}
