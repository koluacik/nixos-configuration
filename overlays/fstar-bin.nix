self: super: {
  z3 = self.callPackage ../nix/z3.nix { };
  fstar-bin = self.callPackage ../nix/fstar.nix { };
}
