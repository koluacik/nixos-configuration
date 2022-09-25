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

map -docstring 'fzf mode' global normal '<c-p>' ': fzf-mode<ret>'

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

hook global BufCreate .*\.rkt %{ set buffer filetype scheme }
hook global BufCreate .*artisan %{ set buffer filetype php }

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
# set global lsp_cmd "kak-lsp -s %val{session} -vvv --log /tmp/kak-lsp.log"
map global normal q ':enter-user-mode lsp<ret>' -docstring 'lsp mode'
hook global WinSetOption filetype=(haskell|nix|c|cpp|python|latex) %{
    lsp-enable-window
    set-option global lsp_config %{
        [language.python.settings._]
        pylsp.plugins.pylint.enabled = true
        pylsp.plugins.pydocstyle.enabled = true
        pylsp.plugins.flake8.enabled = false
        pylsp.plugins.mccabe.enabled = false
        pylsp.plugins.pycodestyle.enabled = false
        pylsp.plugins.pyflakes.enabled = false
        pylsp.plugins.yapf.enabled = false
    }
}

hook global WinSetOption filetype=latex %{
    add-highlighter buffer/wrapping wrap -indent -word -width 100
}

# format
map global user p ':format<ret>' -docstring 'format'

declare-user-mode switch-client
map global user g ':enter-user-mode switch-client<ret>' -docstring 'switch-client mode'
map global switch-client j ':focus %opt{jumpclient}<ret>' -docstring 'switch to jumpclient'
map global switch-client d ':focus %opt{docsclient}<ret>' -docstring 'switch to docsclient'
map global switch-client t ':focus %opt{toolsclient}<ret>' -docstring 'switch to toolsclient'

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

# # rainbows!
# set global rainbow_colors 'rgb:DC322F' 'rgb:b58900' 'rgb:859900' 'rgb:2aa198' 'rgb:268bd2' 'rgb:6c71c4' 'rgb:d33682'
# set global rainbow_mode 0 # only highlight matching pairs with rainbow fg.
# map global user ( ":rainbow-enable-window<ret>" -docstring "enable rainbow"
# map global user ) ":rainbow-disable-window<ret>" -docstring "disable rainbow"

# matching pairs in insert mode
# see: https://github.com/mawww/kakoune/issues/1192#issuecomment-422283119
declare-option -hidden range-specs show_matching_range
hook global -group kakrc-matching-ranges InsertChar '[[\](){}<>]' %{
    eval -draft %{
        try %{
            exec '<esc>;hm<a-k>..<ret>;'
            set window show_matching_range %val{timestamp} "%val{selection_desc}|MatchingChar"
        } catch %{
            set window show_matching_range 0
        }
        hook window -once InsertChar '[^[\](){}<>]' %{
            set window show_matching_range 0
        }
        hook window -once ModeChange .* %{
            set window show_matching_range 0
        }
        hook window -once InsertMove .* %{
            set window show_matching_range 0
        }
    }
}
add-highlighter global/ ranges show_matching_range

# clients
set-option global jumpclient main
set-option global toolsclient tools
set-option global docsclient docs

hook -once global ClientCreate client0 %{
    rename-client main
}

def newtools %{
    new rename-client tools
}

def diagnostics-refresh -params 0 -docstring "switch lsp diagnostic refresh on buf write" %{
    hook buffer -group diagnostics-refresh BufWritePost .* %{
        lsp-diagnostics
    }
}

def no-diagnostics-refresh -params 0 -docstring "disable lsp diagnost refresh" %{
    remove-hooks buffer diagnostics-refresh
}

def newdocs %{
    new rename-client docs
}

set-option global grepcmd "rg --column"

set global modelinefmt '%val{bufname} %val{cursor_line}:%val{cursor_char_column}/%val{buf_line_count} {{context_info}} {{mode_info}} - %val{client}@[%val{session}]'

hook global ModuleLoaded fzf-file %{
    set-option global fzf_file_command "rg"
}

hook global ModuleLoaded fzf-grep %{
    set-option global fzf_grep_command "rg"
}

# surround
declare-user-mode surround
map global surround s ':surround<ret>' -docstring 'surround'
map global surround c ':change-surround<ret>' -docstring 'change'
map global surround d ':delete-surround<ret>' -docstring 'delete'
map global surround t ':select-surrounding-tag<ret>' -docstring 'select tag'
map global user s ':enter-user-mode surround<ret>'
