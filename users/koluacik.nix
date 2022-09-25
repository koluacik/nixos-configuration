{ config, pkgs, systemFlake, ... }:

{
  users.users.koluacik = {
    isNormalUser = true;
    description = "Deniz Koluaçık";
    initialPassword = "password";
    extraGroups = [ "docker" "networkmanager" "wheel" "wireshark" ];
  };

  mySystem.desktop.enable =  true;
  programs.steam.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit systemFlake; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.koluacik = { config, pkgs, ... }: {
      home.stateVersion = "18.09";

      myHome.desktop.enable = true;
      imports = [
        ../modules/home-modules/cli
        ../modules/home-modules/desktop
        ../modules/home-modules/graphical
        ../modules/home-modules/services
      ];
    };
  };
}

