function tadd -d "Add `.torrent` files to `transmission-remote`"
	if not type -q transmission-remote;
		echo "`transmission-remote` not found!";
		return;
	else if not pgrep -l transmission-daemon;
		echo "Daemon not started."
		return;
	end

	set -l delete "true";

	for arg in $argv;
		if test "$arg" = "--no-delete"; or test "$arg" = "-n";
			set delete "false";
			break;
		end
	end

	for torrent in $argv;
		if test "$torrent" != "--no-delete"; and test "$torrent" != "-n";
			if transmission-remote --add $torrent; and test "$delete" = "true";
				rm $torrent;
			end
		end
	end
end

complete -c tadd -s n -l no-delete -d "Do not delete file after adding it";
