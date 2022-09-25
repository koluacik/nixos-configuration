{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    signing = {
      key = "273A5701041B4463CADBDB8352203A5290876FF5";
      signByDefault = true;
    };
    userEmail = "koluacik@disroot.org";
    userName = "Deniz Koluaçık";
    extraConfig.init.defaultBranch = "main";
  };
}
