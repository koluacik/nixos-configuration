{ config, pkgs, options, home-manager, ... }:
{
  system.stateVersion = "20.09";

  networking.hostName = "tempeh";

  imports = [
    ./../modules/system
    ./../modules/devices/dell-g15.nix
    ./../modules/desktop
    ./../modules/nix
    ./hostOverridesForHomeManager.nix

    home-manager.nixosModules.home-manager
    ./../users/koluacik.nix
  ];

  mySystem.desktop.enable = true;
  programs.steam.enable = true;
  mySystem.xautolock.enable = false;

  mySystem.hostOverridesForHomeManager = {
    myHome = {
      desktop.enable = true;
      programs.graphical = {
        im.excludedPrograms = [ pkgs.thunderbird ];
        latex.enable = false;
        drawing.enable = false;
        ide = {
          enable = true;
          excludedPrograms = [ pkgs.jetbrains.clion ];
        };
        media.excludedPrograms = [ pkgs.spotify ];
      };
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = false;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
