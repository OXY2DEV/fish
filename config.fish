# vim:nospell

# 𝐅riendly 𝐈nteractive 𝐒𝐡ell
# ╶╴ 󰈺 ╶╴╾╼╶╴╾╼╶╴╾╼╶╴╾╼╶╴╾╼╶╴╾╼╶╴╾╼
# Created by: OXY2DEV
# Created on: Wed, 20.11.2024; 05:27 PM
# ╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴
# Generated with: `conf-doc.nvim`
# Source: ~/.config/fish/README.md; Lines: 8-15
# Disables the greeting text
set -U fish_greeting ""

# Adds .cargo path
#set -U fish_user_paths "~/.cargo/bin/:~/go/bin/ $fish_user_paths"


# Source: ~/.config/fish/README.md; Lines: 18-22
set -x TERMUX_X11_XSTARTUP "xfce4-session"
set -x DISPLAY ":1"
set -x EDITOR "nvim"


# Source: ~/.config/fish/README.md; Lines: 25-31
alias n "nvim"
alias l "lazygit"
alias f "fisher"
alias g "grep"


# Source: ~/.config/fish/README.md; Lines: 34-50
function bulk_rename
    set -f n 0
    set -f digit 5

    for file in *;
        set -l ext (path extension $file)

        set -l zer (math $digit - (string length $n))
        set -l nam (string repeat '0' -n $zer)$n

        mv $file $nam$ext
        set n (math $n + 1)
    end
end


# Source: ~/.config/fish/README.md; Lines: 53-147
function apply
    set -l patterns \
        '^~$' \
        '^~/.config$' \
        '^~/.config/nvim$' \

    set -l previews \
        (set_color 89B4FA)(printf ' ') \
        (set_color FAB387)(printf '󰒓 ') \
        (set_color A6E3A1)(printf ' ') \

    set -l item 0

    for pattern in $patterns
        set item (math $item + 1)

        if string match -q -r $pattern "$argv"
            echo $previews[$item]
            return
        end
    end

    echo (set_color B4BEFE)(printf '󰉋 ')
end

function reverse
    set -l inp $argv
    set -l out ""

    for i in (seq (string length $inp) -1 1)
        set out "$out"(string sub $inp -s $i -l 1)
    end

    echo $out
end

function cwd
    set -l dir (reverse (pwd | string replace $HOME '~'))
    set -l icon (apply (pwd | string replace $HOME '~'))
    set -l parts (string split / $dir)

    set -l dir_len (string length -- $dir)
    set -l out ''

    set -q $cwd_dir_color; or set cwd_dir_color (set_color B4BEFE)
    set -q $cwd_anchor_color; or set cwd_anchor_color (set_color F2CDCD)
    set -q $cwd_current_color; or set cwd_current_color (set_color -o 89B4FA)

    set -l part_len (count $parts)
    set -q $max_len; or set max_len 15

    set -l p 0
    set -l dont \
        '\.nvim$' \

    for part in $parts
        set part (reverse $part)

        if test $dir_len -le $max_len
            if test $p -eq 0
                set part $cwd_current_color$part
            else
                set part $cwd_dir_color$part
            end
        else
            if test $p -eq 0
                set part $cwd_current_color$part
            else if test $p -eq 3
                break
            else
                for pattern in $dont
                    if string match -q -r $pattern $part
                        set part $cwd_anchor_color$part
                        set out (string join '/' "$part" "$out")
                        continue
                    end
                end

                if string match -q -r '^\.' $part
                    set part $cwd_dir_color(string sub -l 2 $part)
                else
                    set part $cwd_dir_color(string sub -l 1 $part)
                end
            end
        end

        set p (math $p + 1)
        set out (string join '/' "$part" "$out")
    end

    echo (printf ' ')(printf $icon)(printf $out)(printf ' ')
end
# Source: ~/.config/fish/README.md; Lines: 148-196
function fish_prompt
    set -g last_status $status

    set -g prompt_before (set_color 585B70)(printf '╰╴')
    set -g prompt_symbol

    set -l above_before (set_color 585B70)(printf '╭╴')
    set -l above_after  (set_color 585a6f)(printf '──')(set_color 494a5e)(printf '──')(set_color 3a3b4d)(printf '──')(set_color 2c2c3d)(printf '──')

    switch $last_status
        case 0
            # Success
            set -g prompt_symbol (set_color A6E3A1)(printf " ")
        case 2
            # General error
            set -g prompt_symbol (set_color EBA0AC)(printf " ")
        case 2
            # Misuse of shell built-ins
            set -g prompt_symbol (set_color FAB387)(printf " ")
        case 126
            # Cannot execute
            set -g prompt_symbol (set_color F9E2AF)(printf " ")
        case 127
            # Command not found
            set -g prompt_symbol (set_color 7F849C)(printf " ")
        case 128
            # Invalid argument to exit
            set -g prompt_symbol (set_color EBA0AC -o)(printf " ")
        case 130
            # Terminated by <CTRL-C>
            set -g prompt_symbol (set_color 89B4FA)(printf " ")
        case 137
            # Terminated by signal 9(SIGKILL)
            set -g prompt_symbol (set_color F2CDCD)(printf " ")
        case 255
            # Out of range
            set -g prompt_symbol (set_color 89B4FA)(printf "󰆦 ")
        case '*'
            # No idea
            set -g prompt_symbol (set_color CBA6F7)(printf "󰆦 ")
    end

    echo ""
    echo "$above_before"(cwd)"$above_after"
    echo "$prompt_before$prompt_symbol"
end

# Source: ~/.config/fish/README.md; Lines: 199-203
set FZF_DEFAULT_OPTS "--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"
export FZF_DEFAULT_OPTS
# Source: ~/.config/fish/README.md; Lines: 206-224
function s -d "Search"
    set RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "
    set INITIAL_QUERY (string join " " $argv)

    fzf \
        --ansi \
        --disabled \
        --query "$INITIAL_QUERY" \
        --bind "start:reload:$RG_PREFIX {q}" \
        --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
        --bind 'enter:become(nvim {1} +{2})' \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --height=40 \
        --preview-window 'down,10,border-top,+{2}+3/3,~3'
end


# Source: ~/.config/fish/README.md; Lines: 227-230
zoxide init fish | source


# Source: ~/.config/fish/README.md; Lines: 235-246
# Bold mode start
set -g man_bold -o A6E3A1 -b 313244
# Bold mode separator
set -g man_bold_bg -o 313244
# Underline
set -g man_underline -u 89B4FA

set -g man_blink -o F38BA8
set -g man_standout -b black FAB387

# Source: ~/.config/fish/README.md; Lines: 247-286
function man --wraps man -d "Run man with added colors"
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
