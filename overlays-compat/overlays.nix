final: prev:
with prev.lib;
foldl' (flip extends) (_: prev) (import ../overlays/default.nix).overlays final
