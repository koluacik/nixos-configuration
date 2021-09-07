colorscheme solarized-light

add-highlighter global/ number-lines
add-highlighter global/ show-matching
add-highlighter global/ wrap -word

# Tab for indenting and completion
hook global InsertCompletionShow .* %{
    try %{
        execute-keys -draft 'h<a-K>\h<ret>'
        map window insert <tab> <c-n>
        map window insert <s-tab> <c-p>
        hook -once -always window InsertCompletionHide .* %{
            unmap window insert <tab> <c-n>
            unmap window insert <s-tab> <c-p>
        }
    }
}

# Highlight whitespaces
addhl global/whitespace show-whitespaces -spc ' ' -lf ' '
addhl global/trailing-whitespace regex '\h+$' 0:default,white

# Indentation
map global insert <tab> '<a-;><a-gt>'
map global insert <s-tab> '<a-;><a-lt>'

hook global BufWritePre .* %{ try %{ execute-keys -draft \%s\h+$<ret>d } }
# hello world

# https://github.com/Delapouite/kakoune-registers/issues/3#issuecomment-739482262
define-command info-reg -docstring 'populate an info box with the content of registers' %{
    list-registers
    try %{ execute-keys '%<a-s>s^.{30}\K[^\n]*<ret>c…<esc>' }
    execute-keys '%'
    declare-option -hidden str-list reg_info %val{selection}
    execute-keys ':db<ret>'
    info -title registers -- %opt{reg_info}
}

hook global WinCreate .*\.rkt %{ set buffer filetype scheme }

hook global BufSetOption filetype=(nix|haskell|scheme) %{
    set buffer indentwidth 2
}

hook global BufSetOption filetype=nix %{
    set buffer formatcmd 'nixfmt'
}

eval %sh{
    kcr init kakoune
}

# buffers
map global user b ':pick-buffers<ret>' -docstring 'pick buffers'
map global user B ':enter-user-mode -lock pick-buffers<ret>' -docstring 'pick buffers (lock)'
map global user <a-b> ':enter-user-mode buffers<ret>' -docstring 'buffer nav'
map global user <a-B> ':enter-user-mode -lock buffers<ret>' -docstring 'buffer nav (lock)'

# copy
map global user c '<a-|>xsel -b<ret>' -docstring 'copy selection clipboard'

# lsp
eval %sh{kak-lsp --kakoune -s $kak_session}
map global normal q ':enter-user-mode lsp<ret>' -docstring 'lsp mode'
hook global WinSetOption filetype=(haskell|nix|c|cpp|python) %{
    lsp-enable-window
}

# format
map global user p ':format<ret>' -docstring 'format'

# ide
def ide %{
    rename-client main
    set global jumpclient main

    new rename-client tools
    set global toolsclient tools

    new rename-client docs
    set global docsclient docs

    connect terminal
}
declare-user-mode switch
map global user s ':enter-user-mode switch<ret>' -docstring 'switch mode'
map global switch j ':focus %opt{jumpclient}<ret>' -docstring 'switch to jumpclient'
map global switch d ':focus %opt{docsclient}<ret>' -docstring 'switch to docsclient'
map global switch t ':focus %opt{toolsclient}<ret>' -docstring 'switch to toolsclient'

# comment
map global user / ':comment-line<ret>' -docstring 'comment line'
map global user ? ':comment-block<ret>' -docstring 'comment block'

# ergonomics
alias global ns rename-session
map global normal -- - "<a-i>"
map global normal -- + "<a-a>"

# repl stuff
define-command repl-echo -docstring "send the selected text to the repl window (alt)" %{
    nop %sh{
        CUR=`xdotool getactivewindow`
        echo ${kak_selection} | xsel
        xdotool search --name kak_repl_window windowfocus --sync key --clearmodifiers Shift+Insert
        xdotool windowfocus $CUR
    }
}

map global user r ':repl-echo<ret>' -docstring 'repl-echo'
map global user R ':repl<ret>' -docstring ':repl'

# rainbows!
set global rainbow_colors 'rgb:000000' 'rgb:DC322F' 'rgb:b58900' 'rgb:859900' 'rgb:2aa198' 'rgb:268bd2' 'rgb:6c71c4' 'rgb:d33682'
set global rainbow_mode 0 # only highlight matching pairs with rainbow fg.
map global user -- ( ":rainbow-enable-window<ret>" -docstring "enable rainbow"
map global user -- ) ":rainbow-disable-window<ret>" -docstring "disable rainbow"

