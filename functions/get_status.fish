function get_status -d "Creates status badge for given status."
	set_color normal;

	if test $argv[1] -eq 0;
		set_color A6E3A1;
		echo " 󰄳 $argv[1] ";
	else
		set_color F38BA8;
		echo " 󰅙 $argv[1] ";
	end
end
