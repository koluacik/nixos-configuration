{ config, pkgs, lib, systemFlake, ... }: {
  nixpkgs = import ./config.nix;

  nix = {
    channel.enable = false;
    package = pkgs.nixUnstable;
    extraOptions = ''
      keep-outputs = true
      experimental-features = nix-command flakes
    '';
    nixPath = [
      ("nixpkgs=${pkgs.path}")
      ("nixpkgs-overlays=" + systemFlake.outPath + "/overlays-compat")
    ];
    registry = {
      nixpkgs = {
        from = {
          id = "nixpkgs";
          type = "indirect";
        };
        to = {
          type = "path";
          path = systemFlake;
        };
      };
    };
    # https://discourse.nixos.org/t/nix-path-is-not-recognized/38404
    settings.nix-path = config.nix.nixPath;
  };
}
