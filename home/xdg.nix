{ config, pkgs, ... }:

{
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    desktop = "$HOME/desktop";
    documents = "$HOME/documents";
    download = "$HOME/downloads";
    music = "$HOME/documents/music";
    pictures = "$HOME/documents/pictures";
    publicShare = "$HOME/documents/public";
    templates = "$HOME/documents/templates";
    videos = "$HOME/documents/videos";
  };
  xdg.mimeApps.defaultApplications = {
    "image/jpeg" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "image/jpg" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "image/png" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "inode/directory" = [ "ranger.desktop" ];
  };
}
