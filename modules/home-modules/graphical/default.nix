{ config, pkgs, lib, ... }:
{
  imports = [
    ./alacritty.nix
    ./programs.nix
    ./bat.nix
    ./fzf.nix
    ./ranger.nix
    ./vscode.nix
  ];
}

