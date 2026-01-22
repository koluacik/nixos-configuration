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
    libreoffice-fresh
    mpv
    qbittorrent
    spotify
    zathura
  ];

  password = [
    _1password-cli
    _1password-gui
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
    xorg.xev
    xorg.xwininfo
    xsel
  ];

  utils = [
    feh
    graphviz
    gscreenshot
    networkmanagerapplet
    pavucontrol
    playerctl
    pulseaudio # for pactl
    ranger
    solaar
    tabbed
    todoist-electron
    workrave
  ];

  latex = [
    texlive.combined.scheme-full
  ];

  ide = [
    jetbrains.clion
    jetbrains.datagrip
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
  ];

  dev = [
    robo3t
    mongodb-compass
  ];

  games = [
    wineWowPackages.stable
    winetricks
    lutris
  ];
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
          default = [ ];
        };
      });

  config =
    {
      home.packages = # add packages ...
        lists.flatten
          (map
            (categoryName:
              let
                category = config.myHome.programs.graphical.${categoryName};
                programsInCategory = programs.${categoryName};
              in
              filter
                (packageName: !elem packageName category.excludedPrograms) # ... except the excluded ones
                (lists.optionals category.enable programsInCategory)) # ... if the category is enabled
            (attrNames programs)); # ... for each category
    };
}

