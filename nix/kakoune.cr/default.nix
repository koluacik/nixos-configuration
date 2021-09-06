{ crystal, fetchurl, lib, stdenv, fetchFromGitHub }:
let
  icon = fetchurl {
    url = "https://github.com/mawww/kakoune/raw/master/doc/kakoune_logo.svg";
    sha256 = "1x9gdrnrqgzvr1ixr6s8ff6cvz01yp2xdh5ad6nbh6p2d094h617";
    name = "kcr.svg";
  };
in
crystal.buildCrystalPackage rec {
  pname = "kakoune-cr";
  version = "unstable-2021-08-25";

  src = fetchFromGitHub {
    owner = "alexherbo2";
    repo = "kakoune.cr";
    rev = "25d23107de7b8f7656f3f03f36bc47adedf0a7a9";
    sha256 = "t7PlCcLonQRWBnNqefUGz5T60N8QC4zIqHrPaA4J8gs=";
    fetchSubmodules = true;
  };

  crystalBinaries.kcr.src = "src/cli.cr";

  format = "shards";
  shardsFile = ./shards.nix;
  lockFile = ./shard.lock;

  preConfigure = ''
    substituteInPlace src/version.cr --replace \
    '`git describe --tags --always`' \
    '"${version}"'
  '';

  postInstall = ''
    install -Dm555 share/kcr/commands/*/kcr-* -t $out/bin
    install -Dm444 ${icon} -t $out/share/icons/hicolor/scalable/apps/${icon.name}
    install -Dm444 share/kcr/applications/kcr.desktop -t $out/share/applications
    cp -r share/kcr $out/share/
  '';

  doInstallCheck = false;

  meta = with lib; {
    homepage = "https://github.com/alexherbo2/kakoune.cr";
    description = "A command-line tool for Kakoune";
    license = licenses.unlicense;
    # crystal is broken on the others
    platforms = with platforms; [ "x86_64-linux" "i686-linux" ];
  };
}
