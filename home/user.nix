{ config, pkgs, ... }:

{
  imports = [ ./user-private.nix ];

  users.users.koluacik = {
    isNormalUser = true;
    description = "Deniz Koluaçık";
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
