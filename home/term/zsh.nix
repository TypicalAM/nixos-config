{ config, pkgs, ... }:

{
	home.sessionVariables = {
		EDITOR = "nvim";
		GOPATH = "${config.home.homeDirectory}/.go";
		KRITA_NO_STYLE_OVERRIDE = 1;
	};

	programs.zsh = {
		enableAutosuggestions = true;
		enable = true;
		autocd = true;

		history = {
			size = 50000;
			save = 50000;
		};

		oh-my-zsh = {
			enable = true;
			theme = "cloud";
		};

		sessionVariables = {
			COLOR_1 = "\e[8;31;40m";
			COLOR_2 = "\e[8;32;40m";
			COLOR_3 = "\e[8;33;40m";
			COLOR_4 = "\e[8;34;40m";
			COLOR_5 = "\e[8;35;40m";
			COLOR_6 = "\e[8;36;40m";
			COLOR_7 = "\e[8;37;40m";
		};

		shellAliases = {
			# TODO: Package management related
			# Configuration related
			nixrc = "cd /etc/nixos && nvim";
			rebuild = "sudo nixos-rebuild switch";

			# Git aliases
			ga = "git add .";
			gc = "git commit -m";
			gs = "git status";
			gd = "git diff | bat";

			# Navigation and file operations
			lx = "exa -alhG --group-directories-first";
			ra = ". ranger";
			"cd." = "cd ../";
			"cd.." = "cd ../../";
			x = "xdg-open";
			kdiff = "kitty +kitten diff";
			mvr = "bash /home/adam/code/scripts/move_recent_downloads.sh";
			cpp = "rsync -r --info=progress2 ";
			rf = "rm -r -f";

			# Other
			v = "xclip -selection clipboard -o";
			c = "xclip -selection clipboard";
			s = "grep -i --color";
			e = "exit";
			vix = "vim -x";
			vi = "nvim";
			jar = "java -jar";
			ka = "killall";
			hs = "history |s";
			mount = "sudo mount";
			umount = "sudo umount";
			disks = "fdisk -l |s dev";
			check_keys = "xev -event keyboard  | egrep -o 'keycode.*\)'";

			# Functions
			# TODO: Figure out how to implement them properly
			sp = "cd /home/adam/code/python/SpareSnack && source venv/bin/activate && clear && ranger --cmd=sparesnack_workspace";
			sp2 = "cd /home/adam/code/python/SpareSnack && source venv/bin/activate && clear";
			gor = "cd /home/adam/code/golang/bubble-tea/goread && clear && ranger --cmd=goread_workspace";
			gor2 = "cd /home/adam/code/golang/bubble-tea/goread && alias run='go run cmd/goread/main.go' && clear";
			gog = "cd /home/adam/code/golang/bubble-tea/gogist && clear && ranger --cmd=gogist_workspace";
			gog2 = "cd /home/adam/code/golang/bubble-tea/gogist && alias run='go run cmd/gogist/main.go' && clear";
			gop = "cd /home/adam/code/golang/gopoker && clear && ranger --cmd=gopoker_workspace";
			gop2 = "cd /home/adam/code/golang/gopoker && alias up='docker compose -f docker-compose.dev.yml up -d' && alias logs='docker compose -f docker-compose.dev.yml logs -f' && alias test='docker compose -f docker-compose.dev.yml exec backend gotestsum' && alias down='docker compose -f docker-compose.dev.yml down' && clear";
			gotest = "cd /home/adam/code/sandbox/go-test && nvim main.go && clear";
		};
	};
}
