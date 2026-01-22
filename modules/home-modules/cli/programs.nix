{ config, pkgs, lib, ... }:
with pkgs;
with lib;
let programs = {
  cloud = [
    awscli2
    google-cloud-sdk
  ];

  dev = [
    gcc
    jdk
    man-pages
    man-pages-posix
    patchelf
    postgresql
    valgrind
  ];

  nix-utils = [
    nix-du
    nix-index
    nix-prefetch-github
    nix-tree
    nixfmt
  ];

  utils = [
    dig
    fd
    file
    gh
    htop
    killall
    lsof
    nmap
    openfortivpn
    pciutils
    tmux
    tree
    unzip
    whois
  ];

};
in
{
  options.myHome.programs.cli =
    attrsets.genAttrs
      (attrNames programs)
      (name: {
        enable = mkOption {
          type = types.bool;
          default = true;
        };
        excludedPrograms = mkOption {
          type = types.listOf types.package;
          default = [ ];
        };
      });

  config = {
    home.packages =
      lists.flatten (map
        (categoryName:
          let
            category = config.myHome.programs.cli.${categoryName};
            programsInCategory = programs.${categoryName};
          in
          filter
            (packageName: !elem packageName category.excludedPrograms)
            (lists.optionals category.enable programsInCategory))
        (attrNames programs));
  };
}

