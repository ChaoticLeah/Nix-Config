# Common root stuff for any pc/laptop installs
{
  config,
  pkgs,
  nixpkgs-stable,
  inputs,
  system,
  ...
}:
let
  fusion360 = import ./programs/fusion360.nix { inherit pkgs; };
in
{
  imports = [
    ./fonts.nix
    ./games
    ./drawing.nix
    ./services/portals.nix
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

  environment.systemPackages =
    (with pkgs; [
      lua-language-server
      rust-analyzer
      zig
      cargo
      ntfs3g
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
      signal-desktop
      vscode
      feishin
      element-desktop
      wasistlos
      #lmms
      #bambu-studio
      teams-for-linux
      #(import ./programs/fusion360.nix { inherit pkgs; })

      jetbrains.idea-ultimate
      #   For work *dies*
      n8n
      libreoffice
      kdePackages.dolphin
      darktable

      #pmount
      #udisks2
      #udiskie

      (writeShellScriptBin "nvidia-time" ''
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec "$@"
      '')
    ])
    ++ (with nixpkgs-stable.legacyPackages.${pkgs.system}; [
      lmms
    ]);

  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];

}
