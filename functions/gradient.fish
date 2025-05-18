function gradient -d "Creates gradient" -a from to steps stop
	#|fS "feat: Creates gradient from 2 colors"

	function interpolate -d "Interpolates between A & B" -a a b y
		#|fS

		set -l diff $(math $b - $a);
		set -l _y $(math "1 - (1 - $y) ^ 3"); # Use easeOutCubic

		echo $(math "floor($a + ($diff * $_y))");

		#|fE
	end

	set -l _from $(string match -g --regex '(..)(..)(..)' "$from");
	set -l _to $(string match -g --regex '(..)(..)(..)' "$to");

	if not test -n "$steps";
		set steps 10;
	end

	if not test -n "$stop";
		set stop $steps;
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

		if test $step -ge $stop;
			set y $(math "$stop * $increment");
		else if test $step -eq $(math $steps - 1);
			set y 1;
		else
			set y $(math "$step * $increment");
		end

		set -l R $(interpolate $fRGB[1] $tRGB[1] $y);
		set -l G $(interpolate $fRGB[2] $tRGB[2] $y);
		set -l B $(interpolate $fRGB[3] $tRGB[3] $y);

		printf "%02x%02x%02x\n" $R $G $B;
	end

	#|fE
end

