{ config, pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    # enableSshSupport = true;
    # sshKeys = [ "ADDE48C9041AF661ED09C1BC5B5DD82443AB3D44" ];
    pinentryFlavor = "gtk2";
    defaultCacheTtl = 3600; # 1 hour
    maxCacheTtl = 28800; # 8 hours
  };
}
