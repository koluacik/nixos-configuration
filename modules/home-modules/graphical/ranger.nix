{ config, pkgs, lib, ... }:

{
  home.file."./.config/ranger" = {
    source = ../../../home/ranger;
    recursive = true;
  };
}

