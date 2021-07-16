{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    signing = {
      key = "1542E5F82BC40A83";
      signByDefault = true;
    };
    userEmail = "koluacik@disroot.org";
    userName = "Deniz Koluaçık";
    extraConfig.init.defaultBranch = "main";
  };
}
