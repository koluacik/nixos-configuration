{ config, pkgs, inputs, systemFlake, ... }:
{
  nixpkgs = import ./config.nix;

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      keep-outputs = true
      experimental-features = nix-command flakes
    '';
    nixPath = [
      ("nixpkgs-overlays=" + systemFlake.outPath + "/overlays-compat")
      # "nixpkgs=/etc/nix/inputs/nixpkgs"
    ];
  };

  # environment.etc."nix/inputs/nixpkgs".source = systemFlake.inputs.nixpkgs.outPath;

}
