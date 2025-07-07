# Do not do greetings.
set -U fish_greeting ""

# Used for `termux-x11`
set -x TERMUX_X11_XSTARTUP "xfce4-session";
set -x DISPLAY ":1";

set -x EDITOR "nvim";

alias n 'nvim';
alias l 'lsd';
alias lz 'lazygit';
alias ts 'tree-sitter';


# Zoxide setup.
zoxide init fish | source
