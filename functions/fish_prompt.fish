function fish_prompt -d "Fancy prompt for fish."
	#|fS "feat: Last status'
	# Must be retrieved before everything else.

	set -l status_indicator $(get_status $status);

	#|fE

	if test -n "$transient"; and test $transient -eq 1;
		set -g transient 0;

		# Clear from Cursor to end of screen.
		# This gets rid of visual artifacts.
		printf "\e[0J";

		echo $(fancy_timestamp);
		echo (set_color $fish_color_comment)"󰌏 ";
	else
		set -l command_bg A6E3A1;
		set -l insert_bg CDD6F4;
		set -l visual_bg CBA6F7;
		set -l replace_bg F5C2E7;
		set -l replace_block_bg FAB387;

		#|fS "feat: Top of prompt"

		#|fS "style: Vi mode indicator"

		set -l path_bg 38394B;

		set -l mode_indicator_config \
			"$(set_color 1E1E2E --background=$command_bg)  $(set_color $path_bg --background=$command_bg)▐" \
			"$(set_color 1E1E2E --background=$insert_bg)  $(set_color $path_bg --background=$insert_bg)▐" \
			"$(set_color 1E1E2E --background=$visual_bg)  $(set_color $path_bg --background=$visual_bg)▐" \
			"$(set_color 1E1E2E --background=$replace_bg)  $(set_color $path_bg --background=$replace_bg)▐" \
			"$(set_color 1E1E2E --background=$replace_block_bg)  $(set_color $path_bg --background=$replace_block_bg)▐" \
		;

		#|fE

		#|fS "style: Last command duration"

		set -l duration "󰣿 "$(math "$CMD_DURATION / 1000")"s";
		set -l exec_time_config \
			"$(set_color 1E1E2E --background=$command_bg) $duration " \
			"$(set_color 1E1E2E --background=$insert_bg) $duration " \
			"$(set_color 1E1E2E --background=$visual_bg) $duration " \
			"$(set_color 1E1E2E --background=$replace_bg) $duration " \
			"$(set_color 1E1E2E --background=$replace_block_bg) $duration " \
		;

		#|fE

		set -l top_left "$(vi_mode $mode_indicator_config)$(fancy_path)$status_indicator";
		set -l top_left_length $(string length --visible "$top_left");

		set -l top_right "$(platform)$(vi_mode $exec_time_config)";
		set -l top_right_length $(string length --visible "$top_right");

		set -l divider_width $(math "$COLUMNS - ($top_left_length + $top_right_length)")

		if test $divider_width -le 0;
			set divider_width 0;
		end

		echo "$top_left$(string repeat -n $divider_width ' ')$top_right";
		set_color normal;

		#|fE

		#|fS "style:  Prompt"

		set -l path_bg 38394B;

		set -l prompt_indicator_config \
			"$(set_color $command_bg)" \
			"$(set_color $insert_bg)" \
			"$(set_color $visual_bg)" \
			"$(set_color $replace_bg)" \
			"$(set_color $replace_block_bg)" \
		;

		#|fE

		# set_color $mode_hl;
		echo -n "$(vi_mode $prompt_indicator_config)╰ ";
		set_color normal;
	end
end
