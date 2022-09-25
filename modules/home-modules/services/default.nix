{ pkgs, config, lib, ... }:
with lib;
{
  imports = [
    ./dunst.nix
    ./env.nix
    ./gpg.nix
  ];
}

