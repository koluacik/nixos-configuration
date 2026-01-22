{ pkgs, config, lib, ... }:
{
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    hsphfpd.enable = !config.services.pipewire.wireplumber.enable;
  };

  services.blueman.enable = true;

  programs.ssh.startAgent = true;

  networking.networkmanager.enable = true;
}

