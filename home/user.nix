{ config, pkgs, ... }:

{
  imports = [ ./private/user-private.nix ];

  users.users.koluacik = {
    isNormalUser = true;
    description = "Deniz Koluaçık";
    extraGroups = [ "docker" "networkmanager" "wheel" "wireshark" ];
  };
}
