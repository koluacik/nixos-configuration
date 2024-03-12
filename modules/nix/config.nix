{
  config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
    permittedInsecurePackages = [
      "nix-2.15.3"
    ];
  };

  flake = {
    setNixPath = true;
    setFlakeRegistry = true;
  };

  overlays = (import ../../overlays).overlays;
}

