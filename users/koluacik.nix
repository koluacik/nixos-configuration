{ config, pkgs, lib, systemFlake, ... }:

{
  users.users.koluacik = {
    isNormalUser = true;
    description = "Deniz Koluaçık";
    initialPassword = "password";
    extraGroups = [ "docker" "networkmanager" "wheel" "wireshark" "libvirtd" ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit systemFlake;
      # Use this to override home configuration from the host configuration
      hostOverrides = config.mySystem.hostOverridesForHomeManager;
      systemConfig = config;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.koluacik = lib.mkMerge [
      (
        { config, pkgs, systemConfig, ... }:
        {
          home.stateVersion = "18.09";
          imports = [
            ../modules/home-modules/cli
            ../modules/home-modules/desktop
            ../modules/home-modules/graphical
            ../modules/home-modules/services
          ];
        }
      )
      ({ hostOverrides, ... }: hostOverrides)
    ];
  };
}

