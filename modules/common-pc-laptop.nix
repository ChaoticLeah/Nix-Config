{ config, pkgs, inputs, ... }:
# Common root stuff for any pc/laptop installs
{
  imports = [];
    
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland.enable = true;
  
  services.gnome.gnome-keyring.enable = true;
    
  security.pam.services.login.enableGnomeKeyring = true;

  services.udisks2.enable = true;

  # networking.wireless.enable  = true;
  
  environment.systemPackages = with pkgs; [
    firefox
    kitty
    hyprshot
    libnotify
    pavucontrol
    wl-clipboard
    rofi

    #pmount
    #udisks2
    #udiskie
  ];

}
