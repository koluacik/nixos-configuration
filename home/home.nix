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
      # ./vim/vim.nix
      ./wm/xmonad.nix
      ./xdg.nix
    ];

    systemd.user.sessionVariables = {
      WINIT_X11_SCALE_FACTOR = "1";
    };

    programs.direnv.enable = false;
    programs.direnv.nix-direnv.enable = true;

    programs.vscode = {
      enable = false;
      extensions = with pkgs.vscode-extensions; [
        eamodio.gitlens
        yzhang.markdown-all-in-one
        haskell.haskell
        arrterian.nix-env-selector
        justusadam.language-haskell
      ];
    };

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

      # browsers
      chromium
      qutebrowser

      # communication
      slack
      tdesktop
      zoom-us

      # drawing etc.
      gimp
      krita

      # fun!
      discord
      mpv
      # neofetch
      qbittorrent
      spotify
      wineWowPackages.stable

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
      # cabal2nix
      # clang-tools
      # gcc
      # gdb
      # gnumake
      # adoptopenjdk-jre-openj9-bin-15 # for uppaal
      jdk # 17
      man-pages
      man-pages-posix
      patchelf
      poetry
      # valgrind
      rnix-lsp

      jetbrains.pycharm-professional
      jetbrains.clion
      jetbrains.idea-ultimate

      xournalpp
      # texlive.combined.scheme-full

      # utilities etc.
      appimage-run
      arandr
      atool # For ranger archive previews.
      autorandr
      brightnessctl
      # countdown
      dmenu
      dragon-drop # For drag and drop files.
      fd
      ffmpeg
      ffmpegthumbnailer
      file
      git
      # gnupg
      htop
      killall
      libnotify
      lxappearance
      nixfmt
      nix-index
      nix-prefetch-github
      # obs-studio
      pavucontrol
      playerctl
      poppler_utils # For ranger pdf previews.
      # qimgv
      ranger
      ripgrep
      # scrot
      spectacle
      tabbed
      tmux
      tree
      ueberzug # For ranger.
      unzip
      watch
      xclip
      xdotool
      xf86_input_wacom
      xsel

      xorg.xwininfo
      networkmanagerapplet
      whois
      lsof
      feh

      dunst

    ];
  };
}
