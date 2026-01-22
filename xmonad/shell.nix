{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    haskell-language-server
    cabal-install
    haskellPackages.cabal-fmt
    ormolu
    (haskellPackages.ghcWithHoogle (hp: with hp; [
      xmonad
      xmonad-contrib
      # aeson
    ]))
  ];
}
