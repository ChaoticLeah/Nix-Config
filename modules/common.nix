{ config, pkgs, inputs, ... }:
# For common root stuff that trancends between server, desktop, and other things.
{

	imports = [
        ./fonts.nix
        ./drawing.nix
        ./services/sops.nix
        ./services/tailscale.nix

        ./development/git.nix
    ];

	nix.settings = {
		experimental-features = ["flakes" "nix-command"];
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

    programs.java = {
        enable = true;
        package = pkgs.openjdk17;
    };

    services.udisks2.enable = true;
    
	environment.systemPackages = with pkgs; [
        ntfs3g
        firefox
        kitty
        hyprshot
        libnotify
        pavucontrol
        wl-clipboard

		htop
		gnome-keyring
		lua-language-server
		rust-analyzer
		zig
        cargo
        inputs.compose2nix.packages.x86_64-linux.default
        busybox
        tailscale
        sops
	];

	environment.shellAliases = {
		rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#";
		# Cleanup old generations
		nix-gc = "sudo nix-collect-garbage -d";
		v = "nvim .";
		sudovim="sudo -E nvim .";
        edit-secrets = "sudo SOPS_AGE_KEY_FILE=/etc/age/keys.txt sops /etc/nixos/secrets.yaml";
	};

    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 7d";

	#Change the cursor

#	cursor.package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;

#	cursor.name = "BreezX-RosePine-Linux";
}
