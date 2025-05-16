function fish_prompt
    set_color $fish_color_cwd
    echo $(fancy_path)

	if test "$fish_bind_mode" = 'insert'
		set_color 1E1E2E --background=CDD6F4;
		echo -n "  ";

		set_color --background=CDD6F4;
		echo -n "▐";
	else if test "$fish_bind_mode" = 'visual'
		set_color 1E1E2E --background=CBA6F7;
		echo -n "  ";

		set_color --background=CBA6F7;
		echo -n "▐";
	else if test "$fish_bind_mode" = 'replace'
		set_color 1E1E2E --background=F5C2E7;
		echo -n "  ";

		set_color --background=F5C2E7;
		echo -n "▐";
	else if test "$fish_bind_mode" = 'replace_one'
		set_color 1E1E2E --background=FAB387;
		echo -n "  ";

		set_color --background=FAB387;
		echo -n "▐";
	else
		set_color 1E1E2E --background=A6E3A1;
		echo -n "  ";

		set_color --background=A6E3A1;
		echo -n "▐";
	end
    # set_color --background=2F373F
    # echo -n ' ╰╴ '
    set_color normal
    # echo -n ' '
end
