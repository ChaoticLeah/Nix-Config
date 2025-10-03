{ config, pkgs, inputs, ... }:
# Common root stuff for any pc/laptop installs
{
  imports = [
    ./games/mycurrentgames.nix



    #./services/postgres.nix
    #./services/jellyfin.nix
    #./services/immich.nix
    #./services/redis.nix
  ];
    
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland.enable = true;
  
  # networking.wireless.enable  = true;

  boot.supportedFilesystems = [ "ntfs" ];

  programs.kdeconnect.enable = true;

  hardware.bluetooth.enable = true;

  services.blueman.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  environment.systemPackages = with pkgs; [
    hyprpaper
    rofi-power-menu
    overskride
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
    feishin
    element-desktop
    bambu-studio
    teams-for-linux
    
    jetbrains.idea-ultimate

    #pmount
    #udisks2
    #udiskie

    (writeShellScriptBin "nividia-time" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
    '')
  ];



}
