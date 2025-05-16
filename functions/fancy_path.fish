function handle_path_part -d "Decorated path part"
    set -q $raw_path_parts; or set raw_path_parts \
		'\.nvim$' \
	;
    set -q $max_part_len; or set max_part_len 1;

    set -q $raw_path_color; or set raw_path_color $(set_color FAB387);
    set -q $path_color; or set path_color $(set_color 89B4FA);

    set -q $dot_path_color; or set dot_path_color $(set_color A6ADC8);

	for entry in $raw_path_parts;
		if test $(string match --regex $entry "$argv[1]");
			echo $raw_path_color$argv[1];
			return;
		end
	end

	if test $(string match --regex '\..+' "$argv[1]");
		set -l final_path $(string shorten --char='' --max $(math $max_part_len + 1) $argv[1]);
		echo $dot_path_color$final_path;
	else
		set -l final_path $(string shorten --char='' --max $max_part_len $argv[1]);
		echo $path_color$final_path;
	end
end



function fancy_path -d "Fancy path viewer"
	set -l path $PWD;
    set -q $path_separator; or set path_separator "$(set_color 9399B2)/";

	##### Path icons

    set -q $path_patterns; or set path_patterns \
		'\.nvim+$' \
		'.+' \
	;
    set -q $path_icons; or set path_icons \
		"$(set_color $fish_color_quote) " \
		"$(set_color $fish_color_comment)󰉋 " \
	;

	#####

	if test $argv[1];
		set path $argv[1];
	end

	set -l basename $(path basename $path);
    set -q $basename_color; or set basename_color $(set_color 74C7EC);

	set -l output_path;
	set -l readable_path $(string replace $HOME '~' $path);

	for part in $(string split "/" $readable_path);
		if test "$part" = "$basename";
			set output_path $(string join $path_separator $output_path $basename_color$part);
		else
			set output_path $(string join $path_separator $output_path $(handle_path_part $part));
		end
	end

	set -l pattern_index 1;

	for pattern in $path_patterns;
		if test $(string match --regex $pattern "$output_path");
			if test $path_icons[$pattern_index];
				set output_path $path_icons[$pattern_index]$output_path;
				break;
			end
		end

		set pattern_index $(math $pattern_index + 1);
	end

	echo $(set_color --background=38394B)" $output_path ";
end
