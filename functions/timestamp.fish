function to_gradient -d "Creates gradient" -a from to steps
	function lerp -a a b y
		set -l diff $(math $b - $a);
		echo $(math "floor($a + ($diff * $y))")
	end

	set -l _from $(string match -g --regex '(..)(..)(..)' "$from");
	set -l _to $(string match -g --regex '(..)(..)(..)' "$to");

	if not test -n "$steps";
		set steps 10;
	end

	set -l fRGB \
		$(math "0x$_from[1]") \
		$(math "0x$_from[2]") \
		$(math "0x$_from[3]") \
	;

	set -l tRGB \
		$(math "0x$_to[1]") \
		$(math "0x$_to[2]") \
		$(math "0x$_to[3]") \
	;

	set -l increment $(math 1 / "($steps - 1)");

	for step in $(seq 0 $(math $steps - 1));
		set -l y;

		if test $step -eq $(math $steps - 1);
			set y 1;
		else
			set y $(math "$step * $increment");
		end

		set -l R $(lerp $fRGB[1] $tRGB[1] $y);
		set -l G $(lerp $fRGB[2] $tRGB[2] $y);
		set -l B $(lerp $fRGB[3] $tRGB[3] $y);

		printf "%02x%02x%02x\n" $R $G $B;
	end
end

function timestamp -d "A fancy time stamp"
	set -l steps $(math "floor($COLUMNS * 0.4)");
	set -l gradient $(to_gradient "89B4FA" "1E1E2E" $steps)

	set -l C 2;

	for color in $gradient;
		set -l next $gradient[$C];
		set C $(math $C + 1);

		echo -n "$(set_color $next --background=$color)▟";
	end

	set -l text_width $(math "$COLUMNS - $steps");
	set -l time $(date +"%I:%M %p")
	echo -n $(set_color $fish_color_comment)$(string pad -w $text_width "$time")
end

