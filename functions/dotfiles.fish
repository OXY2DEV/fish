function dotfiles -d "Custom git commands for the `.dotfiles` repo(opens `lazygit` by default."
	if test (count $argv) -eq 0; and type -q lazygit
		lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME;
	else
		git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv;
	end
end

complete -c dotfiles -w git;
