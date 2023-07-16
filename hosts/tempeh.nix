{ config, pkgs, options, home-manager, ... }:
{
  system.stateVersion = "20.09";

  networking.hostName = "tempeh";

  imports = [
    ./../modules/system
    ./../modules/devices/dell-g15.nix
    ./../modules/desktop
    ./../modules/nix

    home-manager.nixosModules.home-manager
    ./../users/koluacik.nix
  ];

  mySystem.xautolock.enable = false;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = false;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
