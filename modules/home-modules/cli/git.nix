{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    signing = {
      key = "40AE2767863EF879927FBC75C6BB346850E0D930";
      signByDefault = true;
    };
    userEmail = "koluacik@disroot.org";
    userName = "Deniz Koluacik";
    extraConfig.init.defaultBranch = "main";
  };
}
