function spacer_pre -d "Adds space before the output" --on-event fish_preexec
	echo -e "";
end

function spacer_post -d "Adds space after the output" --on-event fish_postexec
	echo -e "";
end
