{ config, pkgs, ... }: {
  imports = [ ./user.nix ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.koluacik = { config, pkgs, ... }: {
    imports = [
      ./alacritty/alacritty.nix
      ./bash/bash.nix
      ./bat.nix
      ./fzf.nix
      ./git.nix
      ./gpg.nix
      ./kakoune/kakoune.nix
      ./private/home-private.nix
      ./vim/vim.nix
      ./wm/xmonad.nix
      ./xdg.nix
    ];

    systemd.user.sessionVariables = {
      # SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      WINIT_X11_SCALE_FACTOR = "1";
    };

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    services.dunst = {
      enable = true;
      settings = { global = { max_icon_size = 32; }; };
    };

    home.file."./.XCompose".source = ./xcompose;

    home.file."./.config/ranger" = {
      source = ./ranger;
      recursive = true;
    };

    home.packages = with pkgs; [

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

      # fun!
      discord
      discord-canary
      discord-ptb
      mpv
      neofetch
      protontricks
      qbittorrent
      spotify
      tor-browser-bundle-bin
      wineWowPackages.stable
      youtube-dl

      # mail
      thunderbird

      # password
      keepassxc

      # octave
      (octaveFull.withPackages (ps: with ps; [ statistics symbolic ]))

      # office & pdf
      libreoffice
      zathura

      # programming
      cabal2nix
      # clang_11
      clang-tools
      gcc
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
      rnix-lsp

      jetbrains.pycharm-professional
      jetbrains.clion

      xournalpp
      texlive.combined.scheme-full

      # utilities etc.
      ag
      appimage-run
      arandr
      atool # For ranger archive previews.
      autorandr
      brightnessctl
      countdown
      dmenu
      dragon-drop # For drag and drop files.
      # dunst
      fd
      ffmpeg
      ffmpegthumbnailer
      file
      git
      gnupg
      htop
      killall
      kitty
      libnotify
      lxappearance
      nixfmt
      nix-index
      nix-prefetch-github
      obs-studio
      pavucontrol
      playerctl
      poppler_utils # For ranger pdf previews.
      qimgv
      ranger
      ripgrep
      scrot
      spectacle
      tabbed
      tmux
      tree
      ueberzug # For ranger.
      unzip
      watch
      wireshark
      xclip
      xdotool
      xf86_input_wacom
      xsel

    ];
  };
}
