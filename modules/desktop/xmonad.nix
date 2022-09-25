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
      xmobar = "${pkgs.xmobar}/bin/xmobar";
      xmobarConfig0 = pkgs.writeText "xmobarrc_0" (builtins.readFile ../../xmonad/xmobarrc_0);
      xmobarConfig1 = pkgs.writeText "xmobarrc_1" (builtins.readFile ../../xmonad/xmobarrc_1);
      # separate preprocessor step
      # xmonad-config = builtins.readFile ../../xmonad/xmonad.hs;
      # xmonad-hspp = pkgs.runCommand "xmonad-hspp" {} ''
      #   mkdir $out
      #   echo '${xmonad-config}' | ${pkgs.gcc}/bin/cpp \
      #     -DNIXOS_CONFIG_BUILD \
      #     -DXMOBAR_BIN='"${xmobar}"' \
      #     -DXMOBAR_CONFIG_0='"${xmobarConfig0}"' \
      #     -DXMOBAR_CONFIG_1='"${xmobarConfig1}"' > $out/xmonad-hspp
      # '';
      in {
      enable = true;
      extraPackages = (hp: [ hp.xmonad-contrib hp.hpp pkgs.gcc ]);
      # separate preprocessor step
      # config = builtins.trace "${xmonad-hspp} ${xmobar}" builtins.readFile "${xmonad-hspp}/xmonad-hspp";
      config = builtins.readFile ../../xmonad/xmonad.hs;
      ghcArgs = [
        "-cpp"
        "-DNIXOS_CONFIG_BUILD"
        "-DXMOBAR_BIN=\"${xmobar}\""
        "-DXMOBAR_CONFIG_0=\"${xmobarConfig0}\""
        "-DXMOBAR_CONFIG_1=\"${xmobarConfig1}\""
      ];
    };
  };
}

