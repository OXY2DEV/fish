function fancy_timestamp -d "A fancy time stamp"
	#|fS "feat: Fancy looking time stamp"

	set -q timestamp_colors; set -g timestamp_colors \
		89B4FA \
		CBA6F7 \
		FAB387 \
		B4BEFE \
	;
	set -l C $(random 1 $(count $timestamp_colors));

	set -l steps $(math "floor($COLUMNS * 0.4)");
	set -l gradient $(gradient "$timestamp_colors[$C]" "1E1E2E" $steps);

	set -l C 2;

	for color in $gradient;
		set -l next $gradient[$C];
		set C $(math $C + 1);

		echo -n "$(set_color $next --background=$color)▟";
	end

	set -l text_width $(math "$COLUMNS - $steps");
	set -l time $(date +"%I:%M %p");
	set -l time_color $(set_color $fish_color_param);

	echo -n $(set_color $fish_color_comment)$(string pad -w $text_width "at $time_color󰫆 $time");
	set_color normal;

	#|fE
end
