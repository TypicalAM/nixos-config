{ config, pkgs, ... }:

{
	# Starship prompt
	programs.starship = {
		enable = true;
		settings = {
			add_newline = false;
			aws.disabled = true;
			gcloud.disabled = true;
			line_break.disabled = true;

			aws.symbol = "  ";
			conda.symbol = " ";
			dart.symbol = " ";
			directory.read_only = " ";
			docker_context.symbol = " ";
			elixir.symbol = " ";
			elm.symbol = " ";
			git_branch.symbol = " ";
			golang.symbol = " ";
			hg_branch.symbol = " ";
			java.symbol = " ";
			julia.symbol = " ";
			lua.symbol = " ";
			memory_usage.symbol = " ";
			nim.symbol = " ";
			nodejs.symbol = " ";
			package.symbol = " ";
			python.symbol = " ";
			rlang.symbol = "ﳒ ";
			ruby.symbol = " ";
			rust.symbol = " ";
			scala.symbol = " ";
		};
	};
}
