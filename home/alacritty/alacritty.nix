{ config, pkgs, ... }:

{
  home.file."./.config/alacritty/alacritty.yml".source = ./alacritty.yml;
  # Writing alacritty configuration in nix syntax have no advantage over
  # home.file... construct.
  programs.alacritty = {
    enable = true;
  };
}
