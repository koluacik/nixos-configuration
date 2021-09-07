{ config, pkgs, ... }: {
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultOptions = [
      "--color fg:-1,bg:-1,hl:#268bd2,fg+:#073642,bg+:#eee8d5,hl+:#268bd2,info:#b58900,prompt:#b58900,pointer:#002b36,marker:#002b36,spinner:#b58900"
    ];
    changeDirWidgetCommand = "fd -L --type d";
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd -L --type f";
    fileWidgetOptions = [ "--preview 'bat {}'" ];
  };
}
