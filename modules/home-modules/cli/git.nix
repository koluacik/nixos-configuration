{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    signing = {
      key = "E06372F7277AFE56497B956E1F07E7AC4647BB25";
      signByDefault = true;
    };

    settings = {
      user = {
        email = "koluacik@disroot.org";
        name = "Deniz Koluacik";
        init.defaultBranch = "main";
      };
    };
  };
}
