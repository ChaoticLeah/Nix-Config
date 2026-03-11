{ pkgs, inputs, config, lib, ... }:
{
  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ] 
    ++ lib.optional config.services.desktopManager.cosmic.enable xdg-desktop-portal-cosmic
    ++ lib.optional (inputs ? hyprland) xdg-desktop-portal-hyprland;
  };

  # programs.hyprland.portalPackage =
  #   inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
}
