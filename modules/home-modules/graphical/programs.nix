{ config, pkgs, lib, ... }:
with pkgs;
with lib;
let programs = {
  browsers = [
    chromium
    qutebrowser
  ];

  im = [
    discord
    slack
    tdesktop
    thunderbird
    zoom-us
  ];

  drawing = [
    gimp
    krita
    xournalpp
  ];

  media = [
    mpv
    spotify
    libreoffice-fresh
    zathura
    qbittorrent
  ];

  password = [
    _1password
    _1password-gui
    keepassxc
  ];

  xutils = [
    arandr
    autorandr
    brightnessctl
    ffmpeg
    ffmpegthumbnailer
    libnotify
    lxappearance
    poppler_utils
    ueberzug
    xclip
    xdotool
    xdragon
    xf86_input_wacom
    xorg.xwininfo
    xsel
  ];

  utils = [
    pavucontrol
    playerctl
    tabbed
    networkmanagerapplet
    feh
    gscreenshot
    ranger
    graphviz
    solaar
    pulseaudio # for pactl
  ];

  latex = [
    texlive.combined.scheme-full
  ];

  ide = [
    jetbrains.pycharm-professional
    jetbrains.clion
    jetbrains.idea-ultimate
    jetbrains.datagrip
  ];

  games = [ ]; # do not remove this
};

in
{
  options.myHome.programs.graphical =
    attrsets.genAttrs
      (attrNames programs)
      (name: {
        enable = mkOption {
          type = types.bool;
          default = config.myHome.desktop.enable;
        };
        excludedPrograms = mkOption {
          type = types.listOf types.package;
          default = [];
        };
      });

  config =
    let enableGames = config.myHome.programs.graphical.games.enable;
    in
    {
      home.packages = # add packages ...
        lists.flatten (map
          (categoryName:
            let category = config.myHome.programs.graphical.${categoryName};
                programsInCategory = programs.${categoryName};
            in
              filter
                (packageName: !elem packageName category.excludedPrograms) # ... except the excluded ones
                (lists.optionals category.enable programsInCategory)) # ... if the category is enabled
          (attrNames programs)) # ... for each category
        ++ lists.optional enableGames pkgs.wineWowPackages.stable; # ... and games
    };
}

