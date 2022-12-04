{ config, pkgs, nixpkgs, ... }:

{

  imports = [ (nixpkgs + "/nixos/modules/installer/scan/not-detected.nix") ];

  # Nvidia sync mode
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
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

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.driSupport = true;

  services.xserver.wacom.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;

  boot.supportedFilesystems = [ "ntfs" ];

  hardware.xpadneo.enable = true;

  services.fstrim.enable = true;

  powerManagement.cpuFreqGovernor = pkgs.lib.mkDefault "performance";

  specialisation = {
    battery-optimized = with pkgs.lib; {
      configuration = {
        powerManagement.cpuFreqGovernor = mkForce "powersave";
        boot.kernelParams = [ "module_blacklist=nouveau" "module_blacklist=nvidiafb" ];
        hardware.nvidia.modesetting.enable = mkForce false;
        hardware.nvidia.prime.sync.enable = mkForce false;
        hardware.nvidiaOptimus.disable = true;
        services.xserver = {
          videoDrivers = mkForce [ "modesetting" ];
          deviceSection = ''
            Option "DRI" "2"
            Option "TearFree" "true"
          '';
        };
      };
    };
  };

  services.upower = {
    enable = true;
    percentageLow = 20;
    percentageCritical = 15;
    percentageAction = 10;
    criticalPowerAction = "Hibernate";
  };

  fileSystems."/mnt/backup" = {
    device = "/dev/disk/by-uuid/e1db43c7-2b91-4c08-b1bf-078e27752637";
    fsType = "ext4";
  };

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/7CBF36EC06B19D24";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" ];
  };

  # --- auto generated part below

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/63cafd99-2017-433c-9ad8-ef70ff648799";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8FEA-24FB";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/0a4a732d-e09c-430b-ad7b-4d288c21624e"; }];

}

