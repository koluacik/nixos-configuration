self: super: {
  tabbed = super.tabbed.overrideAttrs (oa: {
    patches = oa.patches ++ [ ./0001-print-xid-in-decimal.patch ];
  }
  );
}
