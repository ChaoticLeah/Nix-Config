{
  pkgs,
  lib,
  config,
  inputs,
  hostName,
  ...
}:
{
  programs.waybar = {
    enable = true;
    style = builtins.path { path = ./style.css; };
    settings = [
      {
        layer = "top";
        position = "top";
        mod = "dock";
        height = 16;

        modules-left = [
          "hyprland/workspaces"
          "ext/workspaces"
        ];

        modules-center = [

        ];

        modules-right = [
          "mpris"
          "tray"
          "custom/swaync"
          "pulseaudio"
          "network"
          "battery"
          "clock"
          "custom/power"
        ];

        "custom/swaync" = {
          format = "  ";
          on-click = "''${./scripts/toggle-swaync.sh}";
          tooltip = true;
        };

        pulseaudio = {
          on-click = "pavucontrol";
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            default = [
              ""
              ""
              ""
            ]; # Low, Medium, High
            muted = "";
          };
        };

        network = {
          format-ethernet = "󰈀";
          tooltip-format = "{ifname} via {gwaddr}/{cidr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "Disconnected ⚠";
          format-wifi = "";
          format-alt = "{essid} ({signalStrength}%) ";
          on-click = "nm-connection-editor";
        };

        battery = {
          format = "{icon}";
          format-alt = "{capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        "mpris" = {
          format = "{status_icon} {artist} - {title}";
          format-stopped = "";
          status-icons = {
            "playing" = "  ▶";
            "paused" = "  ⏸";
          };
          player-icons = {
            default = "🎵";
          };
          on-click = "playerctl play-pause";
          max-length = 20;
        };



        "custom/power" = {
          format = " ";
          on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu -theme-str 'window {width: 18em;} listview {lines: 6;}'";
        };

      }
    ];
  };
}
