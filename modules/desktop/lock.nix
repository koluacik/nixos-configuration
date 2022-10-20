{ pkgs, config, lib, ... }:
let
  notifyTime = 10;  # seconds
  killTime = 20;    # minutes
  lockTime = 1;     # minutes
in
with lib;
{
  options.mySystem.xautolock.enable = mkOption {
    type = types.bool;
    default = config.mySystem.desktop.enable;
  };

  config = mkIf (config.mySystem.desktop.enable && config.mySystem.xautolock.enable) {
    services.xserver.xautolock = {
      enable = true;

      extraOptions = [
        "-lockaftersleep"
        "-corners 0-0-"
      ];

      time = lockTime;

      killtime = killTime;
      killer = "/run/current-system/systemd/bin/systemctl suspend";

      enableNotifier = true;
      notify = notifyTime;
      notifier = "${pkgs.libnotify}/bin/notify-send \"Locking in ${builtins.toString notifyTime} seconds\"";
    };
  };
}

