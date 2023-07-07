{ pkgs, config, ... }:
{
  # see nixos wiki and CONFIGURATION.NIX(5)
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      fsIdentifier = "label";
      device = "nodev";
      useOSProber = true;
    };
  };
}

