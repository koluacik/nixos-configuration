{ config, pkgs, ... }:

{
  imports = [
    ./user.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.koluacik = { config, pkgs, ... }:  {
    imports = [
      ./alacritty/alacritty.nix
      ./bash.nix
      ./git.nix
      ./gpg.nix
      ./vim/vim.nix
      ./wm/xmonad.nix
      ./xdg.nix
    ];

    home.file."./.config/nixpkgs/overlays" = {
      source = ../overlays;
      recursive = true;
    };

    home.packages = with pkgs; [

      # bar
      xmobar

      # browsers
      chromium
      qutebrowser

      # communication
      signal-desktop
      slack
      tdesktop
      zoom-us

      # drawing etc.
      # use krita appimage until the bug with wacom tablets are fixed
      gimp

      # fonts
      hack-font

      # fun!
      discord
      neofetch
      mpv
      qbittorrent
      spotify

      # mail
      thunderbird

      # password
      keepassxc

      # office & pdf
      libreoffice
      zathura

      # programming
      clang-tools
      gcc
      ghc
      jdk

      # utilities etc.
      appimage-run
      arandr
      autorandr
      brightnessctl
      dmenu
      dunst
      ffmpeg
      fzf
      git
      gnupg
      htop
      libnotify
      lxappearance
      pavucontrol
      playerctl
      ranger
      spectacle
      tree
      watch
      xclip
      xf86_input_wacom
    ];
  };
}
