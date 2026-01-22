{ pkgs, config, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      fira-code
      fira-code-symbols
      hack-font
      jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
    ];
  };
}

