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

        kak-rainbower = pkgs.kakouneUtils.buildKakounePlugin {
          name = "kak-rainbower";
          src = pkgs.fetchFromGitHub {
            owner = "crizan";
            repo = "kak-rainbower";
            rev = "692c196650edd97da9ed6c275bb9b261630d063d";
            sha256 = "+HGL+l+Zdxo6WaY9T1V8Z/7SnQ9b5pKczHXidvBS1UM=";
            fetchSubmodules = true;
          };
          buildPhase = ''
            g++ rc/rainbower.cpp -O2 -o rc/rainbower
          '';
        };

      in [
        texlab
        jq
        ag
        ripgrep
        kakoune-cr
        (kakoune.override {
          plugins = with kakounePlugins; [
            # kakconfig
            fzf-kak
            kak-ansi
            kak-lsp
            kakoune-buffers
            kakoune-registers
            kak-rainbower
            kak-surround
          ];
        })
      ];
    home.file.".config/kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
    home.file.".config/kak/kakrc/".source= ./kakrc.kak;
  };
}
