{ config, pkgs, options, ... }:

let micvolume = builtins.toString (35 * 65536 / 100);

in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hardware/hardware.nix
    <home-manager/nixos>
    ./home/home.nix
  ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    nixPath = options.nix.nixPath.default
      ++ [ "nixpkgs-overlays=/etc/nixos/overlays-compat/" ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.chromium.enableWideVine = true;

  nixpkgs.overlays = [
    (import ./overlays/xmonad-overlay.nix)
    (import ./overlays/man-pages-posix.nix)
    (import ./overlays/tabbed-overlay.nix)
    (import ./overlays/discord.nix)
    (import ./overlays/krita.nix)
    (import ./overlays/fstar-bin.nix)
    (import ./overlays/countdown.nix)
    (import ./overlays/kakoune-cr.nix)
  ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.loader.efi.efiSysMountPoint = "/boot/EFI";
  boot.loader.grub = {
    enable = true;
    # efiInstallAsRemovable = true;
    efiSupport = true;
    fsIdentifier = "label";
    version = 2;
    device = "nodev";
    useOSProber = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # networking.useDHCP = false;
  # networking.interfaces.eno1.useDHCP = true;
  # networking.interfaces.wlo1.useDHCP = true;

  services.flatpak.enable = true;
  services.sshd.enable = false;

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/home/koluacik/sync";
    user = "koluacik";
  };

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.windowManager.xmonad.enable = true;

  services.xserver.layout = "us,tr";
  services.xserver.xkbOptions =
    "altwin:swap_lalt_lwin,shift:both_capslock,grp:ctrls_toggle";

  environment.variables = {
    EDITOR = "kak";
    VISUAL = "kak";
    PROMPT_COMMAND = "history -a; history -n";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIX_SHELL_PRESERVE_PROMPT = "1";
    FZF_DEFAULT_OPTS =
      "--color fg:-1,bg:-1,hl:#268bd2,fg+:#073642,bg+:#eee8d5,hl+:#268bd2 --color info:#b58900,prompt:#b58900,pointer:#002b36,marker:#002b36,spinner:#b58900";
  };

  programs.steam.enable = true;

  programs.wireshark.enable = true;

  programs.ssh.startAgent = true;

  environment.systemPackages = with pkgs; [ wget vim firefox ];

  # pulse
  # hardware.pulseaudio = {
  #   enable = true;
  #   package = pkgs.pulseaudioFull;
  #   extraModules = [ pkgs.pulseaudio-modules-bt ];
  #   extraConfig = ''
  #     set-default-source alsa_input.pci-0000_00_1f.3.analog-stereo
  #     set-source-port alsa_input.pci-0000_00_1f.3.analog-stereo analog-input-mic
  #     set-source-volume alsa_input.pci-0000_00_1f.3.analog-stereo ${micvolume}
  #   '';
  # };
  hardware.pulseaudio.enable = false;

  # pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    media-session = {
      enable = true;
      config.bluez-monitor.rules = [
        {
          # Matches all cards
          matches = [{ "device.name" = "~bluez_card.*"; }];
          actions = {
            "update-props" = {
              "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
              # mSBC is not expected to work on all headset + adapter combinations.
              "bluez5.msbc-support" = true;
              # SBC-XQ is not expected to work on all headset + adapter combinations.
              "bluez5.sbc-xq-support" = true;
            };
          };
        }
        {
          matches = [
            # Matches all sources
            {
              "node.name" = "~bluez_input.*";
            }
            # Matches all outputs
            { "node.name" = "~bluez_output.*"; }
          ];
          actions = { "node.pause-on-idle" = false; };
        }
      ];
    };
  };

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
    hsphfpd.enable = true;
  };
  services.blueman.enable = true;

  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      fira-code
      fira-code-symbols
      hack-font
      jetbrains-mono
      noto-fonts
      noto-fonts-emoji
    ];
  };

  # see: nixos.wiki/wiki/WireGuard
  networking.firewall = {
    # if packets are still dropped, they will show up in dmesg
    logReversePathDrops = true;
    # wireguard trips rpfilter up
    extraCommands = ''
      ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --sport 3389 -j RETURN
      ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --dport 3389 -j RETURN
    '';
    extraStopCommands = ''
      ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --sport 3389 -j RETURN || true
      ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --dport 3389 -j RETURN || true
    '';
  };

  virtualisation.docker.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "koluacik" ];

  system.stateVersion = "20.09"; # Did you read the comment?
}
