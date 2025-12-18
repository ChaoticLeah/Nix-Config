{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "leah";
  home.homeDirectory = "/home/leah";

  imports = builtins.filter (x: x != null) [
    ./home/git.nix
    ./home/terminal.nix
    ./home/hyprland.nix
    ./home/gnome-settings.nix
    ./home/rofi.nix
    ./home/syncthing.nix
    ./home/waybar/waybar.nix
    ./home/programs/firefox.nix
  ];

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  nixpkgs.config.allowUnfree = true;

  services.udiskie = {
    enable = true;
    notify = true;
    automount = true;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    swaynotificationcenter
    udiskie
    networkmanagerapplet
    networkmanager
    kdePackages.plasma-nm
    kdePackages.plasma-browser-integration
    playerctl

    vlc
    lutris

    alacritty
    neofetch
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # misc
    file
    which
    tree
    zstd
    gnupg

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    obsidian
    godot
    aseprite
    postman
  ];

  programs.home-manager.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
