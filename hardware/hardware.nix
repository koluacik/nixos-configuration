{ config, pkgs, ... }:

{
  # Use Nvidia sync mode for external monitor support.
  # Use Intel for better battery.
  
  # Intel
  # services.xserver.videoDrivers = [ "modesetting" ];

  # Nvidia sync mode
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

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
