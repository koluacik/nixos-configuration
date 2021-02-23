{ config, pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "ADDE48C9041AF661ED09C1BC5B5DD82443AB3D44" ];
    pinentryFlavor = "tty";
  };
}
