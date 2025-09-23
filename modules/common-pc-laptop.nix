{ config, pkgs, inputs, ... }:
# Common root stuff for any pc/laptop installs
{
  imports = [];
    
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland.enable = true;
  
  # networking.wireless.enable  = true;
  
  environment.systemPackages = with pkgs; [
    hyprpaper
    rofi-power-menu
    firefox
    librewolf
    kitty
    hyprshot
    libnotify
    pavucontrol
    wl-clipboard
    rofi
    beeper
    vscode

    jetbrains.idea-ultimate

    #pmount
    #udisks2
    #udiskie
  ];

}
