function generate;
	cd $argv[1];
	set -l is_valid "true";

	for entry in *;
		if test -f $entry; and string match -qr '[cC]hapter.*\.cbz$' $entry;
			set is_valid "false";
			break;
		else if test -f $entry; and string match -qr '[cC]hapter.*\.zip$' $entry;
			set is_valid "false";
			break;
		else if test -d $entry; and string match -qr '[cC]hapter' $entry; and test $(count $(ls $entry)) -gt 0;
			set is_valid "false";
			break;
		end
	end

	if test $is_valid = "true";
		echo "valid: $argv[1]";
		mkdir chapter;

		for file in *;
			if test -f $file; and not string match -qr '[cC]over' $file; and string match -qr '\.(jpg|jpeg|png|webp)$' $file;
				mv $file "chapter";
			end
		end
	else
	end

	cd -;
end


function tochapter -d "Group image into chapters for subdirectories"
	set -l targets;

	if test $(count $argv) -gt 0;
		set targets $argv;
	else
		set targets *;
	end

	for entry in $targets;
		if test -d $entry;
			generate $entry;
		end
	end
end
