{
  pkgs,
  config,
  lib,
  ...
}:

let
  toJSON = builtins.toJSON;
in

{
  # Install the ironbar package
  home.packages = with pkgs; [ ironbar ];

  # Write a JSON config (some examples/tools expect config.json). Using
  # xdg.configFile with toJSON keeps the config in Nix and avoids external
  # conversion steps.
  xdg.configFile."ironbar/config.json" = {
    text = toJSON {
      name = "main";
      icon_theme = null;
      height = 20;
      position = "top";

      start = [
        {
          type = "workspaces";
          clickable = true;
          class = "module module-workspaces";
          focused_class = "focused";
          urgent_class = "urgent";
        }
      ];

      center = [ ];

      end = [
        {
          type = "music";
          class = "module module-music";
          format = "{artist} - {title}";
          truncate = {
            mode = "end";
            length = 20;
          };
        }

        {
          type = "tray";
          class = "module module-tray";
        }

        {
          type = "notifications";
          class = "module module-notifications";
          show_count = true;
          icons = {
            closed_none = "󰍥";
            closed_some = "󱥂";
            closed_dnd = "󱅯";
            open_none = "󰍡";
            open_some = "󱥁";
            open_dnd = "󱅮";
          };
        }

        {
          type = "volume";
          class = "module module-volume";
          format = "{icon} {percentage}%";
          max_volume = 100;
          truncate = "middle";
          icons = {
            volume_high = "󰕾";
            volume_medium = "󰖀";
            volume_low = "󰕿";
            muted = "󰝟";
          };
        }

        {
          type = "network_manager";
          class = "module module-network";
          icon_size = 16;
          format = "{icon}";
          icons = {
            wifi = "󰤨";
            wifi_off = "󰤭";
            ethernet = "󰈀";
            disconnected = "󰤮";
            vpn = "󰦝";
          };
          on_click_left = "nm-connection-editor";
        }

        {
          type = "battery";
          class = "module module-battery";
          format = "{percentage}%";
          thresholds = {
            warning = 20;
            critical = 10;
          };
        }

        {
          type = "clock";
          class = "module module-clock";
          format = "%b %d %H:%M";
        }

        {
          type = "label";
          name = "power";
          class = "module module-power";
          label = "";
          on_click_left = "rofi -show power-menu -modi power-menu:rofi-power-menu -theme-str 'window {width: 18em;} listview {lines: 6;}'";
        }
      ];
    };
    onChange = "${pkgs.ironbar}/bin/ironbar reload";
  };

  # Write the style and helper scripts into the user's XDG config
  xdg.configFile."ironbar/style.css" = {
    text = builtins.readFile ./style.css;
    onChange = "${pkgs.ironbar}/bin/ironbar reload";
  };

  xdg.configFile."ironbar/scripts/toggle-swaync.sh".text =
    builtins.readFile ./scripts/toggle-swaync.sh;
  xdg.configFile."ironbar/scripts/toggle-swaync.sh".executable = true;

  xdg.configFile."ironbar/scripts/toggle-pavucontrol.sh".text =
    builtins.readFile ./scripts/toggle-pavucontrol.sh;
  xdg.configFile."ironbar/scripts/toggle-pavucontrol.sh".executable = true;

  # Instead of using `home.services.systemd.user` (not available in Home Manager
  # `home.*` scope), write a user unit file and add an activation script that
  # enables and starts it. This ensures the service is managed in the user
  # systemd instance and receives the generated config path.
  home.file.".config/systemd/user/ironbar.service".text = ''
    [Unit]
    Description=Ironbar GTK4 bar (user service)
    After=graphical-session.target

    [Service]
    ExecStart=${pkgs.ironbar}/bin/ironbar
    Restart=on-failure
    Environment=IRONBAR_CONFIG=%h/.config/ironbar/config.json
    Environment=IRONBAR_LOG=info
    Environment=IRONBAR_FILE_LOG=warn

    [Install]
    WantedBy=default.target
  '';

  # Ensure systemd user sees the new unit and enable/start it on activation.
  home.activation.ironbar-user-service = ''
    ${pkgs.systemd}/bin/systemctl --user daemon-reload || true
    ${pkgs.systemd}/bin/systemctl --user enable --now ironbar.service || true
  '';

}
