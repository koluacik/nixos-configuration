{ config, pkgs, lib, ... }:
{
  imports = [
    ./bash.nix
    ./git.nix
    ./kakoune.nix
    ./programs.nix
  ];
}

