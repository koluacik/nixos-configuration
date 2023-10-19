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
    nixfmt
    nix-index
    nix-prefetch-github
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
      });

  config = {
    home.packages =
      lists.flatten (map
        (name: lists.optionals config.myHome.programs.cli.${name}.enable programs.${name})
        (attrNames programs));
  };
}

