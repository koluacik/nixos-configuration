# NixOS Configuration

My single-user and single-device [NixOS](https://nixos.org/) configuration [flake](https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS) with [Home Manager](https://nixos.wiki/wiki/Home_Manager) to manage my dotfiles.

## Brief overview of the repository structure

- [flake.nix](./flake.nix) is the top level definition of the system configuration flake. It provides my system configuration and nixpkgs with overlays applied for usage with flake-based nix commands (`nix repl` etc.).
- [home/](./home/) directory is the place for non-NixOS specific dotfiles.
- [hosts/](./hosts) declares devices.
- [users/](./users/) has user configuration and user space programs for the declared users.
- [modules/](./modules/) is my attempt at modularizing the system configuration. These modules are imported by the declared hosts and users. [modules/home-modules](./modules/home-modules/) has Home Manager modules, meanwhile the other sibling directories are NixOS modules.
- [overlays/](./overlays/) is my changes applied to the upstream nixpkgs. The modified nixpkgs is also an output of this flake so that I can use it in my flake commands. For old nix commands (`nix-shell` etc.), I use the [overlays-compat trick](https://nixos.wiki/wiki/Overlays#Using_nixpkgs.overlays_from_configuration.nix_as_.3Cnixpkgs-overlays.3E_in_your_NIX_PATH).
- [xmonad/](./xmonad/) directory has my [xmonad](https://xmonad.org/) and [xmobar](https://hackage.haskell.org/package/xmobar) configurations. The cabal project is included in my `haskellPackages` package set and included as an extra package in my [nixos module for the wm](./modules/desktop/xmonad.nix). I run `rm ~/.cache/xmonad/*; cabal install --installdir=./ --install-method=copy --overwrite-policy=always && cp my-xmonad ~/.cache/xmonad/xmonad-x86_64-linux && xmonad --restart` instead of waiting for `nixos-rebuild` to complete after each change I made in my config for rapid feedback from the changes I've made. Compared to `nix-shell` -based recompilation scripts, this setup seems to be the best of both worlds for me. `nixos-rebuild` forces the recompilation of xmonad after an update, meaning I don't get a surprise 10-minutes wait with no wm after a reboot, meanwhile having the ability to test the changes to the xmonad configuration without waiting for too long.
