{ pkgs, config, lib, ... }:
with lib;
{
  imports = [
    ./direnv.nix
    ./dunst.nix
    ./env.nix
    ./gpg.nix
    ./virt-manager.nix
    ./xidlehook.nix
  ];
}

