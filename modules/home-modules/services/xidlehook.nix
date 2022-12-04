{ pkgs, config, lib, ... }:
let
  SECONDS = 1;
  MINUTES = 60 * SECONDS;

  notifyTime = 10 * SECONDS;
  lockTime = 5 * MINUTES;
  suspendTime = 30 * MINUTES;

  socketPath = "$XDG_RUNTIME_DIR/xidlehook.sock";

  timers = [
      {
        delay = lockTime - notifyTime;
        command = "${pkgs.libnotify}/bin/notify-send \"Locking screen in ${builtins.toString notifyTime} seconds\"";
        canceller = "dunstctl close";
      }
      {
        delay = notifyTime;
        command = "${pkgs.xlockmore}/bin/xlock";
      }
      {
        delay = suspendTime - lockTime - notifyTime;
        command = "/run/current-system/systemd/bin/systemctl suspend";
      }
  ];

  toTimer = timer:
    "--timer ${builtins.toString timer.delay} ${
      lib.escapeShellArgs [
        timer.command
        (lib.attrByPath [ "canceller" ] "" timer)
      ]
    }";

  script = pkgs.writeShellScript "xidlehook"
  ''
  ${lib.concatStringsSep " " [
    "${pkgs.xidlehook}/bin/xidlehook"
    "--not-when-audio"
    "--not-when-fullscreen"
    "--detect-sleep"
    "--socket ${socketPath}"
    "${lib.concatMapStringsSep " " toTimer timers}"
  ]}
  '';

in
with lib;
{
  options.myHome.xidlehook.enable =
    mkOption {
      type = types.bool;
      default = true;
    };
  config = mkIf config.myHome.xidlehook.enable {
    home.packages = [ pkgs.xidlehook ];
    systemd.user.services.xidlehook = {
      Unit = {
        Description = "xidlehook service";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        ConditionEnvironment = [ "DISPLAY" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${script}";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    programs.bash.shellAliases.xidlehook-client = "xidlehook-client --socket ${socketPath}";
  };
}

