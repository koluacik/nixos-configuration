final: prev:

let
  xmonadGH = prev.fetchFromGitHub {
    owner = "xmonad";
    repo = "xmonad";
    rev = "v0.17.1";
    sha256 = "g4yKGTlBBv2HtGx7J1N3OUG/lDD/go24ywuCj+MDTfo=";
  };

  xmonad-contribGH = prev.fetchFromGitHub {
    owner = "xmonad";
    repo = "xmonad-contrib";
    rev = "v0.17.1";
    sha256 = "KsotlGCqhJ/zJ8YZn0KIyx8/SuoLaTa2gK4Uxgq21fM=";
  };

in
{
  haskellPackages = prev.haskellPackages.override (old: {
    overrides = prev.lib.composeExtensions (old.overrides or (_: _: { }))
      (hfinal: hprev: rec {
	# uncomment if newer versions required before nixpkgs gets updated
        # xmonad = hfinal.callCabal2nix "xmonad" xmonadGH { };
        # xmonad-contrib = hfinal.callCabal2nix "xmonad-contrib" xmonad-contribGH { };
        my-xmonad = hfinal.callCabal2nix "my-xmonad" ../xmonad { };
      });
  });
}
