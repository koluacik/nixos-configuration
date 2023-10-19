{ config, pkgs, options, home-manager, ... }:
{
  system.stateVersion = "20.09";

  networking.hostName = "tofu";

  imports = [
    ./../modules/system
    ./../modules/devices/pavilion.nix
    ./../modules/desktop
    ./../modules/nix
    ./hostOverridesForHomeManager.nix

    home-manager.nixosModules.home-manager
    ./../users/koluacik.nix
  ];

  mySystem.xautolock.enable = false;

  mySystem.hostOverridesForHomeManager = {
    myHome = {
      desktop.enable = true;
      programs.graphical = {
        latex.enable = false;
        ide = {
          enable = false;
        };
        media.excludedPrograms = [ pkgs.spotify ];
      };
      programs.cli = {
        cloud.enabled = false;
        dev.excludedPrograms = [ pkgs.postgresql ];
      };
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = false;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
