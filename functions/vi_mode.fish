function vi_mode -d "Gets Vi mode indicator" -a command insert visual replace replace_block
	#|fS "feat: Get Vi mode"

	set -l mode_hl;

	if test "$fish_bind_mode" = 'insert'
		echo -n "$insert";
	else if test "$fish_bind_mode" = 'visual'
		echo -n "$visual";
	else if test "$fish_bind_mode" = 'replace'
		echo -n "$replace";
	else if test "$fish_bind_mode" = 'replace_one'
		echo -n "$replace_block";
	else
		echo -n "$command";
	end

	#|fE
end
