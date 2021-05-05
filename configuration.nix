{ config, pkgs, options, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware/hardware.nix
      <home-manager/nixos>
      ./home/home.nix
    ];

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  nix.nixPath =
      options.nix.nixPath.default ++
      [ "nixpkgs-overlays=/etc/nixos/overlays-compat/" ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.chromium.enableWideVine = true;

  nixpkgs.overlays = [
    (import ./overlays/xmonad-overlay.nix)
    (import ./overlays/man-pages-posix.nix)
    (import ./overlays/tabbed-overlay.nix)
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.windowManager.xmonad.enable = true;

  services.xserver.layout = "us,tr";
  services.xserver.xkbOptions = "altwin:swap_lalt_lwin,shift:both_capslock,grp:alt_space_toggle";

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    vim
    firefox
  ];

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = "set-source-port alsa_input.pci-0000_00_1f.3.analog-stereo analog-input-mic";
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  system.stateVersion = "20.09"; # Did you read the comment?

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "koluacik" ];
}
