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

  # specialisation.intel = {
  #   inheritParentConfig = true;
  #   configuration = {
  #     services.xserver.videoDrivers = [ "modesetting" ];
  #     services.xserver.useGlamor = true;
  #     hardware.nvidia.prime.sync.enable = pkgs.lib.mkForce false;
  #     programs.bash.loginShellInit = pkgs.lib.mkForce "";
  #     hardware.opengl = {
  #       enable = true;
  #       driSupport = true;
  #       driSupport32Bit = true;
  #       extraPackages = with pkgs; [vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl];
  #     };
  #   };
  # };

  # Nvidia sync mode
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  services.xserver.screenSection = ''
    Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
    Option         "AllowIndirectGLXProtocol" "off"
    Option         "TripleBuffer" "on"
  '';
  hardware.nvidia.powerManagement.enable = true;

  # No tear
  # programs.bash.loginShellInit = "/etc/nixos/hardware/force-pipeline.sh";

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.driSupport = true;

  services.xserver.wacom.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;

  boot.supportedFilesystems = [ "ntfs" ];

  hardware.xpadneo.enable = true;

  services.fstrim.enable = true;

  fileSystems."/mnt/backup" = {
    device = "/dev/disk/by-uuid/e1db43c7-2b91-4c08-b1bf-078e27752637";
    fsType = "ext4";
  };

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/7CBF36EC06B19D24";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" ];
  };
}
