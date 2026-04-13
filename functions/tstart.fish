function tstart -d "Start `transmission-daemon`"
	if not type -q transmission-daemon;
		echo "`transmission-daemon` not found!";
		return;
	end

	pkill transmission-daemon;
	transmission-daemon --logfile ~/transmission.log;
end
