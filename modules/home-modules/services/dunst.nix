{ config, pkgs, lib, ... }:
with lib;
{
  options.myHome.dunst.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.myHome.dunst.enable {
    services.dunst = {
      enable = true;
      settings = { global = { max_icon_size = 32; }; };
    };
  };
}

