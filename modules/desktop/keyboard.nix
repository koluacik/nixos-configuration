{ pkgs, config, ... }:
{
  services.xserver = {
    layout = "us,tr";

    # swap left alt and left windows keys
    # left shift + right shift to switch layouts
    # pause key for compose
    xkbOptions =
      "altwin:swap_lalt_lwin,grp:shifts_toggle,compose:paus";
  };
}

