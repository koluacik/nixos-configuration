{ pkgs }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    haskell-language-server
    (haskellPackages.ghcWithHoogle (hp: with hp; [
      xmonad
      xmonad-contrib
    ]))
  ];
}
