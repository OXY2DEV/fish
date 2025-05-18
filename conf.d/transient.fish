function update_prompt
	# Activate transient prompt if,
	#     1. Command-line is valid.
	#     2. Command-line is empty & not in paging mode.
	if commandline --is-valid || test -z $(commandline | string collect) && not commandline --paging-mode
		set -g transient 1;
		commandline -f repaint;
	end

	commandline -f execute;
end

bind --user --mode default \r update_prompt
bind --user --mode insert \r update_prompt
