{pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cabal-install
    (haskellPackages.ghcWithHoogle (hp: with hp; [
      xmonad
      xmonad-contrib
      haskell-language-server
      taffybar
    ]))
  ];
}
