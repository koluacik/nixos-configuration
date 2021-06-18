# Thank you IvanMalison!
# https://github.com/IvanMalison/dotfiles/blob/master/dotfiles/config/xmonad/overlay.nix

final: prev:

let
  xmonadGH = prev.fetchFromGitHub {
    owner = "xmonad";
    repo = "xmonad";
    rev = "131fd3669f6c2952d3094016d14873fdfe66f98c";
    sha256 = "1swn4lfdvbancc2vqlidprr8lnllq9cwqiknri5q9ikg4n2clc7r";
  };
  xmonad-contribGH = prev.fetchFromGitHub {
    owner = "xmonad";
    repo = "xmonad-contrib";
    rev = "a99c76cce48ce70cf30094a3a74f54bcb03eb3d7";
    sha256 = "11p3x469yy2c9q3vir600s21lmb1vaki1qc9pgb7vm900l0cr3ym";
  };

in {
  haskellPackages = prev.haskellPackages.override (old: {
    overrides = prev.lib.composeExtensions (old.overrides or (_: _: { }))
      (hfinal: hprev: rec {
        xmonad = hfinal.callCabal2nix "xmonad" xmonadGH { };
        xmonad-contrib =
          hfinal.callCabal2nix "xmonad-contrib" xmonad-contribGH { };
      });
  });
}
