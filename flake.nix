{
  description = "@koluacik's desktop configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-util = {
      url = "github:numtide/flake-utils";
    };

  };

  outputs = { nixpkgs, home-manager, self, ... }@inputs:

    let
      system = "x86_64-linux";

      pkgs = import nixpkgs (import ./modules/nix/config.nix // {
        inherit system;
      });
    in
    {
      nixosConfigurations = {
        tofu = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = inputs // {systemFlake = self;};
          modules = [ ./hosts/tofu.nix ];
        };
      };

      legacyPackages.${system} = pkgs;

      # devShells.${system} = {
      #   xmonad = (import ./xmonad/shell.nix);
      # };
    };
}
