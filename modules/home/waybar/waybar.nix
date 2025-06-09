{ pkgs, lib, config, inputs, hostName, ... }:
{
	programs.waybar = {
		enable = true;
		style = builtins.path {path = ./style.css;};
		settings = [{
			layer = "top";
			position = "top";
			mod = "dock";
			height = 16;

			modules-left = [
				"hyprland/workspaces"
			];

			modules-center = [

			];

			modules-right = [
				"pulseaudio"
				"network"
				"clock"
				"custom/power"
			];

			pulseaudio = {
    				on-click = "pavucontrol";
  			};

  			network = {
				format-ethernet = "󰈀";
   				tooltip-format = "{ifname} via {gwaddr}/{cidr}";
    				format-linked = "{ifname} (No IP)";
    				format-disconnected = "Disconnected ⚠";
   				format-wifi = "{essid} ({signalStrength}%) ";
  			};



			"custom/power" = {
				    format = "   ";
				    on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu -theme-str 'window {width: 18em;} listview {lines: 6;}'";

			};

		}];
	};
}
