function platform -d "Gets OS platform"
	set_color $fish_color_comment;
	set -l uname $(uname -a);

	if test $(string match --regex "Android" $uname);
		echo -n " 󰀲 Termux ";
	else if test $(string match --regex "Darwin" $uname);
		echo -n " 󰀵 MacOS ";
	else
		echo -n "  $(uname) ";
	end

	set_color normal;
end
