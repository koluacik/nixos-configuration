final: prev: {
  z3 = final.callPackage ../nix/z3.nix { };
  fstar-bin = final.callPackage ../nix/fstar.nix { };
}
