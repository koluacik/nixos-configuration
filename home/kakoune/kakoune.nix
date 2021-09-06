{ config, pkgs, ... }: {
  config = {
    home.packages = with pkgs;
      let
        kakconfig = pkgs.writeTextFile (rec {
          name = "kakrc.kak";
          destination = "/share/kak/autoload/${name}";
          text = builtins.readFile ./kakrc.kak;
        });
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
      in [
        jq
        kakoune-cr
        (kakoune.override {
          plugins = with kakounePlugins; [
            kakconfig
            kak-ansi
            kak-surround
            kakoune-buffers
            kakoune-registers
            kak-lsp
          ];
        })
      ];
    home.file.".config/kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
  };
}

