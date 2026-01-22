{ pkgs, config, ... }:
{
  services.xserver.xkb = {
    layout = "us,tr";

    # swap left alt and left windows keys
    # left shift + right shift to switch layouts
    # pause key for compose
    options =
      # "altwin:swap_lalt_lwin,grp:shifts_toggle,compose:paus";
      "grp:shifts_toggle,compose:paus";
  };
}

