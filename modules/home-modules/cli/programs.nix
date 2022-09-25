{ config, pkgs, lib, ... }:
with pkgs;
with lib;
let programs = {
  dev = [
    jdk
    man-pages
    man-pages-posix
    patchelf
    poetry
    valgrind
    gcc
    postgresql
  ];

  nix-utils = [
    nixfmt
    nix-index
    nix-prefetch-github
    fd
  ];

  utils = [
    lsof
    whois
    unzip
    tree
    tmux
    killall
    htop
    file
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
      });

  config = {
    home.packages =
      lists.flatten (map
        (name: lists.optionals config.myHome.programs.cli.${name}.enable programs.${name})
        (attrNames programs));
  };
}

