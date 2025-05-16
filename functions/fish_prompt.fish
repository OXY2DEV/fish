function fish_prompt -d "Fancy prompt for fish."
	#|fS "feat: Last status'
	# Must be retrieved before everything else.

	set -l status_part $(get_status $status);

	#|fE

	#|fS "feat: Get Vi mode"

	set -l path_bg 38394B;
	set -l mode_hl;

	if test "$fish_bind_mode" = 'insert'
		set_color 1E1E2E --background=CDD6F4;
		echo -n "  ";

		set mode_hl CDD6F4;
		set_color $path_bg --background=CDD6F4;
		echo -n "▐";
	else if test "$fish_bind_mode" = 'visual'
		set_color 1E1E2E --background=CBA6F7;
		echo -n "  ";

		set mode_hl CBA6F7;
		set_color $path_bg --background=CBA6F7;
		echo -n "▐";
	else if test "$fish_bind_mode" = 'replace'
		set_color 1E1E2E --background=F5C2E7;
		echo -n "  ";

		set mode_hl F5C2E7;
		set_color $path_bg --background=F5C2E7;
		echo -n "▐";
	else if test "$fish_bind_mode" = 'replace_one'
		set_color 1E1E2E --background=FAB387;
		echo -n "  ";

		set mode_hl FAB387;
		set_color $path_bg --background=FAB387;
		echo -n "▐";
	else
		set_color 1E1E2E --background=A6E3A1;
		echo -n "  ";

		set mode_hl A6E3A1;
		set_color $path_bg --background=A6E3A1;
		echo -n "▐";
	end

	#|fE

	#|fS "chore: Render stuff"

	echo -n $(fancy_path);
	echo $status_part;

	set_color normal;

	set_color $mode_hl;
	echo -n "╰ ";
	set_color normal;

	#|fE
end
