{
  config,
  pkgs,
  inputs,
  ...
}:
# For common root stuff that trancends between server, desktop, and other things.
{

  imports = [
    ./services/sops.nix
    ./services/tailscale.nix
    ./nixvim
    ./development/git.nix
    ./development/git-hooks.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      inherit (prev.lixPackageSets.stable)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;

  nix.settings = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
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

  programs.java = {
    enable = true;
    package = pkgs.openjdk17;
  };

  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    htop
    gnome-keyring
    inputs.compose2nix.packages.x86_64-linux.default
    busybox
    tailscale
    sops
    nixfmt-rfc-style
    treefmt
  ];

  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake .#";
    # Cleanup old generations
    nix-gc = "sudo nix-collect-garbage -d";
    v = "nvim .";
    edit-secrets = "sudo SOPS_AGE_KEY_FILE=/etc/age/keys.txt sops /etc/nixos/secrets.yaml";
  };

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 7d";
}
