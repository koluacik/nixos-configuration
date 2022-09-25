{
  config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };

  overlays = (import ../../overlays).overlays;
}

