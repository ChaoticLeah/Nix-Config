{ pkgs, lib, config, inputs, hostName, ... }:
{
	programs.waybar = {
		enable = true;
		style = builtins.path {path = ./style.css;};
		settings = [{
			layer = "top";
			position = "top";
			mod = "dock";

		}];
	};
}
