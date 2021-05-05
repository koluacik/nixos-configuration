{ config, pkgs, ... }:

{
  # Use Nvidia sync mode for external monitor support.
  # Use Intel for better battery.

  # Intel
  # services.xserver.videoDrivers = [ "modesetting" ];
  # services.xserver.useGlamor = true;

  # Intel no tear
  # services.xserver.videoDrivers = [ "intel" ];
  # services.xserver.deviceSection = ''
  #   Option "DRI" "2"
  #   Option "TearFree" "true"
  # '';

  # Nvidia sync mode
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # No tear
  programs.bash.loginShellInit = "/etc/nixos/hardware/force-pipeline.sh";

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.driSupport = true;

  services.xserver.wacom.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;

  boot.supportedFilesystems = [ "ntfs" ];

  services.fstrim.enable = true;

  fileSystems."/mnt/backup" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  fileSystems."/mnt/hdd" = {
    device = "/dev/sda4";
    fsType = "ntfs";
  };
}
