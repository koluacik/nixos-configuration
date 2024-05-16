{ config, pkgs, lib, systemConfig, ... }:
with lib; {
  options.myHome.virt-manager-settings.enable = mkOption {
    type = types.bool;
    default = systemConfig.virtualisation.libvirtd.enable;
  };

  config = mkIf config.myHome.virt-manager-settings.enable {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}
