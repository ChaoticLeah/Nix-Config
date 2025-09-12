{ config, pkgs, inputs, ... }:
# For common root stuff that trancends between server, desktop, and other things.
{

	imports = [
        ./fonts.nix
        ./drawing.nix
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

	programs.neovim = {
		enable = true;
		vimAlias = true;
	};

    programs.git = {
        enable = true;
        package = pkgs.gitFull;
        config.credential.helper = "libsecret";
    };

    programs.java = {
        enable = true;
        package = pkgs.openjdk17;
    };

    services.gnome.gnome-keyring.enable = true;
    
    security.pam.services.login.enableGnomeKeyring = true;

	environment.systemPackages = with pkgs; [
        firefox
        kitty
        hyprshot
        libnotify
        pavucontrol
        wl-clipboard
        rofi-wayland

		htop
		gnome-keyring
		lua-language-server
		rust-analyzer
		zig
        inputs.compose2nix.packages.x86_64-linux.default
        busybox
	];

	environment.shellAliases = {
		rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#leah";
		# Cleanup old generations
		nix-gc = "sudo nix-collect-garbage -d";
		v = "nvim .";
		sudovim="sudo -E nvim .";
	};

	#Change the cursor

#	cursor.package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;

#	cursor.name = "BreezX-RosePine-Linux";
}
