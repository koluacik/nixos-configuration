self: super:
with super.lib;
let overlays = (import <nixpkgs/nixos> { }).config.nixpkgs.overlays;
in foldl' (flip extends) (_: super) overlays self
