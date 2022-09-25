final: prev:

let
  xmonadGH = prev.fetchFromGitHub {
    owner = "xmonad";
    repo = "xmonad";
    rev = "v.0.17.1";
    sha256 = "g4yKGTlBBv2HtGx7J1N3OUG/lDD/go24ywuCj+MDTfo=";
  };

  xmonad-contribGH = prev.fetchFromGitHub {
    owner = "xmonad";
    repo = "xmonad-contrib";
    rev = "v.0.17.1";
    sha256 = "KsotlGCqhJ/zJ8YZn0KIyx8/SuoLaTa2gK4Uxgq21fM=";
  };

in
{
  haskellPackages = prev.haskellPackages.override (old: {
    overrides = prev.lib.composeExtensions (old.overrides or (_: _: { }))
      (hfinal: hprev: rec {
        xmonad = hfinal.callCabal2nix "xmonad" xmonadGH { };
        xmonad-contrib = hfinal.callCabal2nix "xmonad-contrib" xmonad-contribGH { };
      });
  });
}
