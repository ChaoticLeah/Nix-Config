{ config, pkgs, inputs, ... }:

{

	imports = [
		./fonts.nix
	];

	nix.settings = {
		experimental-features = ["flakes"];
	};

	networking.networkmanager.enable = true;

	time.timeZone = "Europe/Amsterdam";

	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "nl_NL.UTF-8";
		LV_IDENTIFICATION = "nl_NL.UTF-8";
		LC_MEASUREMENT = "nl_NL.UTF-8";
		LC_MONETARY = "nl_NL.UTF-8";
		LC_NAME = "nl_NL.UTF-8";
		LC_NUMERIC = "nl_NL.UTF-8";
		LC_PAPER = "nl_NL.UTF-8";
		LC_TELEPHONE = "nl_NL.UTF-8";
		LC_TIME = "nl_NL.UTF-8";
	};

	# Keymap in X11. Might not need soon
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	services.displayManager.sddm.enable = true;
	services.displayManager.sddm.wayland.enable = true;
	programs.hyprland.enable = true;

	programs.neovim = {
		enable = true;
	};

	environment.systemPackages = with pkgs; [
		kitty
		firefox
		vlc
		hyprshot
		git
		rofi-wayland
		libnotify
		htop
		gnome-keyring
		lua-language-server
		rust-analyzer
		zig
		pavucontrol
	];

	environment.shellAliases = {
		rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#leah";
		# Cleanup old generations
		nix-gc = "sudo nix-collect-garbage -d";
		v = "nvim .";
		sudoedit="function _sudoedit(){sudo -e '$1';};_sudoedit";
	};

	#Change the cursor

#	cursor.package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;

#	cursor.name = "BreezX-RosePine-Linux";
}
