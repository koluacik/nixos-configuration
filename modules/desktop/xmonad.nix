{ pkgs, config, lib, ... }:
with lib;
{
  options.mySystem.xmonad.enable = mkOption {
    description = "Enable XMonad and xmobar.";
    type = types.bool;
    default = config.mySystem.desktop.enable;
  };

  config = mkIf (config.mySystem.desktop.enable && config.mySystem.xmonad.enable) {
    services.xserver.windowManager.xmonad = let
      in {
      enable = true;
      extraPackages = (hp: [hp.my-xmonad]);
      config = builtins.readFile ../../xmonad/app/Main.hs;
    };
  };
}

