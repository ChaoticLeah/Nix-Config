{
  pkgs,
  lib,
  config,
  ...
}:

{
  programs.rofi = {
    enable = true;
    location = "center";
    terminal = "alacritty";
    extraConfig = {
      show-icons = true;
      window-thumbnail = true;
    };

  };
}
