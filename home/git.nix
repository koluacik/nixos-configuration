{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    signing = {
      # key = "D681B1D02389F278FE522AA2D441A77A3A4E7828";
      key = "1542E5F82BC40A83";
      signByDefault = true;
    };
    userEmail = "koluacik@disroot.org";
    userName = "Deniz Koluaçık";
  };
}
