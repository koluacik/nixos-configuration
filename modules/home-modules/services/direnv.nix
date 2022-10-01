{ config, pkgs, lib, ... }:
with lib;
{
  options.myHome.direnv.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.myHome.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
