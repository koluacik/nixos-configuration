{ config, pkgs, lib, ... }:
with lib;
{
  options.myHome.gpg.enable = mkOption {
      type = types.bool;
      default = true;
    };

  config = mkIf config.myHome.gpg.enable {
    services.gpg-agent = {
      enable = true;
      pinentryFlavor = if config.myHome.desktop.enable then "gtk2" else "tty";
      defaultCacheTtl = 3600; # 1 hour
      maxCacheTtl = 28800; # 8 hours
    };
    home.packages = with pkgs; [ gnupg ];
  };
}

