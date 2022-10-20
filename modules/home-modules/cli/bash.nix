{ config, pkgs, lib, ... }: with lib;
{
  options.myHome.bash.enable =
    mkOption {
      type = types.bool;
      default = true;
    };

  config = mkIf config.myHome.bash.enable {
    programs.bash = {
      enable = true;
      shellAliases.today = "date +%F";
      historyControl = [ "erasedups" "ignorespace" ];
      bashrcExtra = builtins.readFile ../../../home/bash/bashrc;
    };
  };
}

