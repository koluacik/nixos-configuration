{ config, pkgs, ... }:

{
  home.file."./.config/alacritty/themes" = {
    source = ./themes;
    recursive = true;
  };
  home.file."./.config/alacritty/base-config.yml".source = ./base-config.yml;
  home.file."./.local/bin/switch-theme".source = ./switch-theme;
  programs.alacritty = { enable = true; };
}
