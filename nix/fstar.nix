{ stdenv, lib
, fetchurl
, gmp
, gnutar
, z3
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  name = "fstar-bin";
  version = "2021.06.06";

  src = fetchurl {
    url = "https://github.com/FStarLang/FStar/releases/download/v2021.06.06/fstar_2021.06.06_Linux_x86_64.tar.gz";
    sha256 = "0pq06yrqbq2wbx1lxhxchm8f55y8jjq3kc7dz7vwkwkf9mc9lik4";
  };

  nativeBuildInputs = [
    gnutar
    autoPatchelfHook
  ];

  buildInputs = [
    gmp
    z3
  ];

  unpackPhase = ''
    tar -zxvf $src
  '';

  installPhase = ''
    mkdir -p $out
    cp -av fstar/bin $out/bin
    cp -av fstar/ulib $out/ulib
  '';
}
