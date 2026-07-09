function l -d "Lists directories through `eza`, `lsd` or `ls`"
	if type -q eza
		if test (count $argv) -eq 0
			command eza --icons --group-directories-first -- $argv;
		else
			command eza --icons -- $argv;
		end
	else if type -q lsd
		command lsd -- $argv;
	else
		command ls -- $argv;
	end
end

if type -q eza
	complete -c l -w eza;
else if type -q lsd
	complete -c l -w lsd;
else
	complete -c l -w ls;
end

if test $(uname) = "Darwin"
	# fix(eza,MacOS): Compatibility changes for Mac
	#
	# On MacOS, `eza` looks for config at `~/Library/Application Support/eza`,
	# we modify it here to match `Linux`.
	set -gx EZA_CONFIG_DIR '~/.config/eza/';
end

