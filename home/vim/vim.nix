{ config, pkgs, ... }:

{
  home.file."./.config/nvim/coc-settings.json".source = ./coc-settings.json;
  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ./init.vim;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [

      coc-json
      vim-airline  
      vim-airline-themes

      vim-nix
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
      # { # gruvbox
      #   plugin = gruvbox;
      #   config = builtins.readFile ./gruvbox.vim;
      # }
      { # NeoSolarized
        plugin = NeoSolarized;
        config = builtins.readFile ./solarized.vim;
      }
    ];
  };
}
