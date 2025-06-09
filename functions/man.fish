# Bold mode start
set -g man_bold -o A6E3A1 -b 313244
# Bold mode separator
set -g man_bold_bg -o 313244
# Underline
set -g man_underline -u 89B4FA

set -g man_blink -o F38BA8
set -g man_standout -b black FAB387

function man --wraps man --description 'Run man with added colors'
    set -lx LESS_TERMCAP_mb (set_color -o $man_blink) # Blink mode
    set -lx LESS_TERMCAP_md (set_color -o $man_bold)(printf " ")  # Bold mode

    # Mode reset
    set -lx LESS_TERMCAP_me (printf " ")(set_color normal)

    # Underlined text
    set -lx LESS_TERMCAP_us (set_color -o $man_underline)
    set -lx LESS_TERMCAP_ue (printf "\e[0m")

    # Standout text
    set -lx LESS_TERMCAP_so (set_color -o $man_standout)
    set -lx LESS_TERMCAP_se (printf "\e[0m")

    set -lx LESS '-R -s'

    set --local --export MANPATH $MANPATH

    # special case for NetBSD and FreeBSD: set MANPATH if not already set
    # see https://github.com/fish-shell/fish-shell/blob/555af37616893160ad1afb208a957d6a01a7a315/share/functions/man.fish#L15
    if test -z "$MANPATH"
        if set path (command man -p 2>/dev/null)
            set MANPATH (string replace --regex '[^/]+$' '' $path)
        else
            set MANPATH ""
        end
    end

    # prepend the directory of fish manpages to MANPATH
    set fish_manpath $__fish_data_dir/man
    if test -d $fish_manpath
        set --prepend MANPATH $fish_manpath
    end

    command man $argv
end
