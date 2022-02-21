# Thank you IvanMalison!
# https://github.com/IvanMalison/dotfiles/blob/master/dotfiles/config/xmonad/overlay.nix

final: prev:

let
  xmonadGH = prev.fetchFromGitHub {
    owner = "xmonad";
    repo = "xmonad";
    rev = "af354f7528ada1de451365a0f5138ef10a318360";
    sha256 = "08iifadqwgczmkz727gx0k8vm2xpincp4binpw8zdk8z4c7a3bxj";
  };
  xmonad-contribGH = prev.fetchFromGitHub {
    owner = "xmonad";
    repo = "xmonad-contrib";
    rev = "da2fb360b81c969854a66e246cc37a0864edf8d0";
    sha256 = "0kf5jvfdz017qbrfwlk6z54msf6klrm3cd71dl977r54lmwg9m98";
  };

in {
  haskellPackages = prev.haskellPackages.override (old: {
    overrides = prev.lib.composeExtensions (old.overrides or (_: _: { }))
      (hfinal: hprev: rec {
        # xmonad = hfinal.callCabal2nix "xmonad" xmonadGH { };
        # xmonad-contrib =
        #   hfinal.callCabal2nix "xmonad-contrib" xmonad-contribGH { };
        xmonad = hfinal.xmonad_0_17_0;
        xmonad-contrib = hfinal.xmonad-contrib_0_17_0;
      });
  });
}
