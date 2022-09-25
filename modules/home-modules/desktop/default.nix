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
  };
}

