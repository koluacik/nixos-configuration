{ config, pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    defaultCacheTtl = 3600; # 1 hour
    maxCacheTtl = 28800; # 8 hours
  };
  home.packages = with pkgs; [ gnupg ];
}
