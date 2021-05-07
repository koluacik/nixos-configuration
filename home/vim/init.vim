"" Sadly, setting colorscheme to dracula at init.vim after installing
"" dracula-vim declaratively gives errors. I am using plug for it
"" until it is fixed.
"" sane colors
set termguicolors

let aspath = $HOME . '/.config/alacritty/colorstate'
if filereadable(aspath)
    if readfile(aspath)[0] ==# "dark"
        set bg=dark
    else
        set bg=light
    endif
endif

"" sane splits
set splitbelow splitright hidden

"" sane editing
set mouse=a nu

"" sane search
set ignorecase smartcase incsearch

"" sane messages
set noshowmode shortmess=aoOtTIcF

"" sane clipboard. Example: use \\yy for copying to clipboard.
noremap <leader><leader> "+

"" sane noh (nohighlight for searches)
nnoremap <silent><Esc> :noh<CR>

"" sane terminal
tnoremap <silent><C-q> <C-\><C-n>
au TermOpen * setlocal nonumber signcolumn=no

"" sane tabs
set expandtab shiftwidth=4 softtabstop=-1

"" sane latex (requires tex-live)
nmap <leader>l :!pdflatex %<CR>
nmap <leader><leader>l :!pdflatex --shell-escape %<CR>
