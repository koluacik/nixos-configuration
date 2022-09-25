{ pkgs, config, ... }:
{
  time.timeZone = "Europe/Istanbul";

  # I use this because of Windows being silly.
  time.hardwareClockInLocalTime = true;
}


