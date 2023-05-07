{ config, pkgs, options, home-manager, ... }:
{
  system.stateVersion = "20.09";

  networking.hostName = "tofu";

  imports = [
    ./../modules/system
    ./../modules/devices/pavilion.nix
    ./../modules/desktop
    ./../modules/nix

    home-manager.nixosModules.home-manager
    ./../users/koluacik.nix
  ];

  mySystem.xautolock.enable = false;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
