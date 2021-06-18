final: prev: {
  krita = prev.appimageTools.wrapType1 {
    name = "krita";
    src = prev.fetchurl {
      url =
        "https://download.kde.org/stable/krita/4.4.3/krita-4.4.3-x86_64.appimage";
      sha256 = "09nhyn4624hpwagbls25lacqxf7rb22vjnb1mnnxi4fmy9zmmcwm";
    };
  };
}
