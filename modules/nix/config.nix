{
  config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
    permittedInsecurePackages = [ "nix-2.15.3" ];
  };

  overlays = (import ../../overlays).overlays;
}
