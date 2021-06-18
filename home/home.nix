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
      ./private/home-private.nix
    ];


    systemd.user.sessionVariables = {
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      WINIT_X11_SCALE_FACTOR = "1";
    };

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    home.file."./.config/ranger" = {
      source = ./ranger;
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
      gimp
      krita

      # fonts
      hack-font

      # fun!
      discord
      discord-canary
      discord-ptb
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

      # octave
      (octaveFull.withPackages (ps: [ps.statistics]))

      # office & pdf
      libreoffice
      zathura

      # programming
      cabal2nix
      # clang_11
      # clang-tools
      # gcc
      gdb
      ghc
      gnumake
      haskell-language-server
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
      atool  # For ranger archive previews.
      autorandr
      brightnessctl
      dmenu
      dragon-drop  # For drag and drop files.
      dunst
      ffmpeg
      ffmpegthumbnailer
      fzf
      git
      gnupg
      htop
      libnotify
      lxappearance
      pavucontrol
      playerctl
      poppler_utils  # For ranger pdf previews.
      qimgv
      ranger
      scrot
      spectacle
      tabbed
      tree
      ueberzug  # For ranger.
      unzip
      watch
      xclip
      xf86_input_wacom
    ];
  };
}
