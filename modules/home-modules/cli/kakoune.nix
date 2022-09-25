{ config, pkgs, lib, ... }: with lib;
{
  options.myHome.kakoune = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };

    enableTex = mkOption {
      type = types.bool;
      default = config.myHome.programs.graphical.latex.enable;
    };
  };

  config = mkIf config.myHome.kakoune.enable {
    home.packages = with pkgs;
      let
        kak-surround = pkgs.kakouneUtils.buildKakounePlugin {
          name = "kak-surround";
          src = pkgs.fetchFromGitHub {
            owner = "h-youhei";
            repo = "kakoune-surround";
            rev = "efe74c6f434d1e30eff70d4b0d737f55bf6c5022";
            sha256 = "0PicMTkYRnhtrFAMWVgynE4HfoL9/EHZIu4rTSE+zSU=";
            fetchSubmodules = true;
          };
        };

      in
      [
        jq
        ripgrep
        rnix-lsp
        kakoune-cr
        (kakoune.override {
          plugins = with kakounePlugins; [
            fzf-kak
            kak-ansi
            kak-lsp
            kakoune-buffers
            kakoune-registers
            kak-surround
          ];
        })
      ] ++ (if config.myHome.kakoune.enableTex then [ texlab ] else [ ]);

    home.file.".config/kak-lsp/kak-lsp.toml".source = ../../../home/kakoune/kak-lsp.toml;
    home.file.".config/kak/kakrc/".source = ../../../home/kakoune/kakrc.kak;
  };
}

