{ config, pkgs, ... }:
let
  myKak = let
    config = pkgs.writeTextFile (rec {
      name = "kakrc.kak";
      destination = "/share/kak/autoload/${name}";
      text = ''
        colorscheme solarized-light
        add-highlighter global/ number-lines
      '';
    });
  in pkgs.kakoune.override {
    plugins = with pkgs.kakounePlugins; [ kak-ansi config ];
  };

in {
  imports = [ ./user.nix ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.koluacik = { config, pkgs, ... }: {
    imports = [
      ./alacritty/alacritty.nix
      ./bash.nix
      ./git.nix
      ./gpg.nix
      ./vim/vim.nix
      ./wm/xmonad.nix
      ./xdg.nix
    ];

    # home.file."./.config/nixpkgs/overlays" = {
    #   source = ../overlays;
    #   recursive = true;
    # };

    systemd.user.sessionVariables = {
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      WINIT_X11_SCALE_FACTOR = "1";
    };

    programs.direnv.enable = true;
    programs.direnv.enableNixDirenvIntegration = true;

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
      mpv
      neofetch
      protontricks
      qbittorrent
      spotify
      youtube-dl

      # mail
      thunderbird

      # password
      keepassxc

      # office & pdf
      libreoffice
      zathura

      # programming
      cabal2nix
      clang-tools
      gcc
      gdb
      ghc
      gnumake
      haskell-language-server
      # jdk
      adoptopenjdk-jre-openj9-bin-15 # for uppaal
      manpages
      man-pages-posix
      patchelf
      poetry
      racket
      stack
      valgrind

      # kak
      # kakoune
      myKak

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
      qimgv
      ranger
      scrot
      spectacle
      tabbed
      tree
      unzip
      watch
      xclip
      xf86_input_wacom
    ];
  };
}
