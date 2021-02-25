{ config, pkgs, ... }:

{
  imports = [
    ./user.nix
  ];

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

    nixpkgs.config.allowUnfree = true;


    home.packages = with pkgs; [

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

      # password
      keepassxc

      # office & pdf
      libreoffice
      zathura

      # programming
      clang-tools
      gcc
      ghc

      # utilities etc.
      appimage-run
      arandr
      autorandr
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
      tree
      watch
      xclip
    ];
  };
}
