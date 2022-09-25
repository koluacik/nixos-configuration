# NixOS Configuration

My single-user and single-device [NixOS](https://nixos.org/) configuration [flake](https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS) with [Home Manager](https://nixos.wiki/wiki/Home_Manager) to manage my dotfiles.

## Brief overview of the repository structure

- [flake.nix](./flake.nix) is the top level definition of the system configuration flake. It provides my system configuration and nixpkgs with overlays applied for usage with flake-based nix commands (`nix repl` etc.).
- [home/](./home/) directory is the place for non-NixOS specific dotfiles.
- [hosts/](./hosts) declares devices.
- [users/](./users/) has user configuration and user space programs for the declared users.
- [modules/](./modules/) is my attempt at modularizing the system configuration. These modules are imported by the declared hosts and users. [modules/home-modules](./modules/home-modules/) has Home Manager modules, meanwhile the other sibling directories are NixOS modules.
- [overlays/](./overlays/) is my changes applied to the upstream nixpkgs. The modified nixpkgs is also an output of this flake so that I can use it in my flake commands. For old nix commands (`nix-shell` etc.), I use the [overlays-compat trick](https://nixos.wiki/wiki/Overlays#Using_nixpkgs.overlays_from_configuration.nix_as_.3Cnixpkgs-overlays.3E_in_your_NIX_PATH).
- [xmonad/](./xmonad/) directory has my [xmonad](https://xmonad.org/) and [xmobar](https://hackage.haskell.org/package/xmobar) configurations. Xmobar executable and config paths are determined during the build time in [./modules/desktop/xmonad.nix](./modules/desktop/xmonad.nix).
