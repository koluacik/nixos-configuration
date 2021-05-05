{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "man-pages-posix";
  version = "2017-a";

  src = fetchurl {
    url =
      "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/${name}/${name}-${version}.tar.xz";
    sha256 = "ce67bb25b5048b20dad772e405a83f4bc70faf051afa289361c81f9660318bc3";
  };

  makeFlags = [ "MANDIR=$(out)/share/man" ];
  postInstall = "mkdir -p $out/bin";
  outputDocdev = "out";

  meta = {
    description = "POSIX man-pages (0p, 1p, 3p)";
    homepage = "https://www.kernel.org/doc/man-pages/";
    repositories.git =
      "https://git.kernel.org/pub/scm/docs/man-pages/man-pages-posix.git";
    platforms = lib.platforms.unix;
    priority = 29;
  };
}
