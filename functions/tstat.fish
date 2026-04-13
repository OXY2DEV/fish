function tstat -d "Stats for `transmission-remote`"
	if not type -q transmission-remote;
		echo "`transmission-remote` not found!";
		return;
	end

	transmission-remote --session-info;
end

