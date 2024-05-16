{ config, pkgs, options, home-manager, ... }:
{
  system.stateVersion = "20.09";

  networking.hostName = "semruk";

  imports = [
    ./../modules/system
    ./../modules/devices/semruk_v9_2_3.nix
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
        im.excludedPrograms = [
          pkgs.thunderbird
          pkgs.slack
          pkgs.tdesktop
        ];
        latex.enable = false;
        drawing.enable = false;
        browsers.excludedPrograms = [ pkgs.qutebrowser ];
        media.excludedPrograms = [
          pkgs.spotify
          pkgs.libreoffice-fresh
        ];
      };
    };
  };

  services.xserver.wacom.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable=true;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = false;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
