function update_prompt
	commandline -f expand-abbr suppress-autosuggestion

	if commandline --is-valid || test -z "$(commandline)"
		if commandline --paging-mode && test -n "$(commandline)"
			commandline -f accept-autosuggestion;
			return;
		end

		set -g transient 1;
		commandline -f repaint execute;
		return;
	end

	commandline -f execute
end

# function set_state
# 	commandline --function expand-abbr suppress-autosuggestion
#
# 	if commandline --is-valid || test -z "$(commandline)"↩
# 		if commandline --paging-mode && test -n "$(commandline)"
# 			commandline -f accept-autosuggestion;
# 			return 0;
# 		end
#
# 		set -g TRANSIENT 1;
# 		commandline --function repaint execute
# 		return 0;
# 	end
#
# 	commandline -f execute
# end

bind --user --mode default \r update_prompt
bind --user --mode insert \r update_prompt


# bind --user --mode default \cj set_state
# bind --user --mode insert \cj set_state
#
# bind --user --mode default \cc set_state
# bind --user --mode insert \cc set_state
#
# bind --user --mode default \cd set_state
# bind --user --mode insert \cd set_state
