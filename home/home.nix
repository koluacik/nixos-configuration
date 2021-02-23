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
      ./xdg.nix
    ];

    nixpkgs.config.allowUnfree = true;


    home.packages = with pkgs; [

      # browsers
      chromium
      qutebrowser

      # communication
      tdesktop
      signal-desktop
      slack

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
      zoom

      # password
      keepassxc

      # pdf
      zathura

      # programming
      clang-tools
      gcc
      ghc

      # utilities etc.
      appimage-run
      git
      gnupg
      htop
      pavucontrol
      ranger
      tree
      watch
      xclip
    ];
  };
}
