{ pkgs, config, ... }:
{
  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      fira-code
      fira-code-symbols
      hack-font
      jetbrains-mono
      noto-fonts
      noto-fonts-emoji
    ];
  };
}

