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
    libreoffice
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
    spectacle
    ranger
    graphviz
  ];

  latex = [
    texlive.combined.scheme-full
  ];

  ide = [
    jetbrains.pycharm-professional
    jetbrains.clion
    jetbrains.idea-ultimate
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
      });

  config =
    let enableGames = config.myHome.programs.graphical.games.enable;
    in
    {
      home.packages =
        lists.flatten (map
          (name: lists.optionals config.myHome.programs.graphical.${name}.enable programs.${name})
          (attrNames programs)) ++
        lists.optional enableGames pkgs.wineWowPackages.stable;
    };
}

