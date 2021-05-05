{ config, pkgs, ... }:

{
  home.file."./.config/alacritty/alacritty-dark.yml".source =
    ./alacritty-dark.yml;
  home.file."./.config/alacritty/alacritty-light.yml".source =
    ./alacritty-light.yml;
  home.file."./.config/alacritty/switch-to-dark.sh".source =
    ./switch-to-dark.sh;
  home.file."./.config/alacritty/switch-to-light.sh".source =
    ./switch-to-light.sh;
  programs.alacritty = { enable = true; };
}
