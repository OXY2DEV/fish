# Do not do greetings.
set -U fish_greeting ""

# Used for `termux-x11`
set -x TERMUX_X11_XSTARTUP "xfce4-session";
set -x DISPLAY ":1";

set -x EDITOR "nvim";

alias n 'nvim';
alias lz 'lazygit';
alias ts 'tree-sitter';

alias cr 'cargo';
alias dt 'dotfiles';

# NOTE: `yt-dlp` aliases
alias ya "yt-dlp -x -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"; # Downloads *playlist* in a separate directory.

# feat(cargo): Add cargo binary path to `$PATH`
set --append PATH $HOME/.cargo/bin/

# FIX(MacOS, Lazygit): Change config directory for `lazygit`.
set -l uname $(uname -a);

if test $(string match --regex "Darwin" $uname);
	export XDG_CONFIG_HOME=$HOME/.config;
end

fish_config theme choose catppuccin-mocha

# Zoxide setup.
zoxide init fish | source
