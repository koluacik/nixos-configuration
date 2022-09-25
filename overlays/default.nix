{
  overlays = [
    (final: prev: {
      tabbed = prev.tabbed.overrideAttrs (oa: {
        patches = oa.patches ++ [ ./0001-print-xid-in-decimal.patch ];
      });
    })
    (import ./xmonad-0-17-1.nix)
  ];
}
