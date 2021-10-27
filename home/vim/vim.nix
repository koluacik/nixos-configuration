{ config, pkgs, ... }:

let
  myNeoSolarized = pkgs.vimUtils.buildVimPlugin {
    pname = "myNeoSolarized";
    name = "myNeoSolarized";
    src = fetchGit ./NeoSolarized;
  };
  taboo = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "taboo";
    name = "taboo";
    src = pkgs.fetchgit {
      url = "https://github.com/gcmt/taboo.vim";
      rev = "caf948187694d3f1374913d36f947b3f9fa1c22f";
      sha256 = "06pizdnb3gr4pf5hrm3yfzkz99y9bi2vwqm85xknzgdvl1lisj99";
    };
  };

in {
  home.file."./.config/nvim/coc-settings.json".source = ./coc-settings.json;
  home.file."./.local/bin/reload-nvim-config".source = ./reload-nvim-config;
  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ./init.vim;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [

      coc-clangd
      coc-json
      editorconfig-vim
      vim-airline
      vim-airline-themes
      vim-nix

      { # NeoSolarized
        plugin = myNeoSolarized;
        config = builtins.readFile ./solarized.vim;
      }
      { # haskell-vim
        plugin = haskell-vim;
        config = builtins.readFile ./haskell-vim.vim;
      }
      { # coc-nvim
        plugin = coc-nvim;
        config = builtins.readFile ./coc-nvim.vim;
      }
      { # vim-slime
        plugin = vim-slime;
        config = builtins.readFile ./vim-slime.vim;
      }
      { # nerdtree
        plugin = nerdtree;
        config = builtins.readFile ./nerdtree.vim;
      }
      { # taboo
        plugin = taboo;
        config = builtins.readFile ./taboo.vim;
      }
    ];
  };
}
