{ pkgs, config, lib, ... }:
with lib;
{
  imports = [
    ./pipewire.nix
    ./xmonad.nix
    ./fonts.nix
    ./keyboard.nix
    ./lock.nix
  ];

  options.mySystem.desktop.enable = mkOption {
    description = "Enable X server, DE/WM configuration, sound, and GUI programs.";
    type = types.bool;
    default = true;
  };

  config = mkIf config.mySystem.desktop.enable {
    services.xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}

