{ lib, stdenv, libnotify, speechd, termdown }:

stdenv.mkDerivation rec {
  name = "countdown";
  version = "1.0.0";

  nativeBuildInputs = [ libnotify speechd termdown ];
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cat << "EOF" > $out/bin/countdown
    #! /usr/bin/env bash
    TERMDOWNCMD="${termdown}/bin/termdown -W -f term"
    $TERMDOWNCMD -T "timer is running" $@
    ${libnotify}/bin/notify-send -u critical "time is up"
    $TERMDOWNCMD -T "time is up" --exec-cmd 'if [ `expr {0} % 2` -eq 0 ]; then ${speechd}/bin/spd-say "time is up"; fi'
    EOF

    chmod +x $out/bin/countdown
    '';

  outputs = [ "out" ];

  meta = with lib; {
    description = "My terminal countdown script with text-to-speech and notifications";
  };
}
