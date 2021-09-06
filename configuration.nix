{ config, pkgs, options, ... }:

let micvolume = builtins.toString (35 * 65536 / 100);
in

{
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

  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;

  services.flatpak.enable = true;
  services.sshd.enable = true;

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.windowManager.xmonad.enable = true;

  services.xserver.layout = "us,tr";
  services.xserver.xkbOptions =
    "altwin:swap_lalt_lwin,shift:both_capslock,grp:sclk_toggle,compose:rctrl";

  environment.variables = {
    EDITOR = "kak";
    VISUAL = "kak";
    PROMPT_COMMAND = "history -a; history -n";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIX_SHELL_PRESERVE_PROMPT = "1";
    FZF_DEFAULT_OPTS = "--color fg:-1,bg:-1,hl:#268bd2,fg+:#073642,bg+:#eee8d5,hl+:#268bd2 --color info:#b58900,prompt:#b58900,pointer:#002b36,marker:#002b36,spinner:#b58900";
  };

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [ wget vim firefox ];

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      set-default-source alsa_input.pci-0000_00_1f.3.analog-stereo
      set-source-port alsa_input.pci-0000_00_1f.3.analog-stereo analog-input-mic
      set-source-volume alsa_input.pci-0000_00_1f.3.analog-stereo ${micvolume}
      '';
  };

  hardware.bluetooth.enable = true;
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


  system.stateVersion = "20.09"; # Did you read the comment?
}
