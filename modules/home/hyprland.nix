{
  pkgs,
  lib,
  config,
  hostName,
  ...
}:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${./wallpapers/wallpaper1.png}"
      ];

      wallpaper = [
        ",${./wallpapers/wallpaper1.png}"
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    #	bitdepth, 10, cm, hdr, sdrbrightness, 1.2, sdrsaturation, 0.98;
    extraConfig = (
      if hostName == "hyprleah" then
        ''
          			monitor = DP-1, 2560x1440, 0x0, 1

          			monitor = HDMI-A-1, 1920x1080, 2560x0, 1

                      
                      env = GDK_SCALE,1
                      env = GDK_DPI_SCALE,1
                      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
                      env = QT_SCALE_FACTOR,1
                      env = QT_QPA_PLATFORM,wayland
                      env = GDK_BACKEND,wayland
                      env = MOZ_ENABLE_WAYLAND,1
                      env = XCURSOR_SIZE,24
          		''
      else
        ""
    );

    settings = {
      "$terminal" = "alacritty";
      "$mod" = "SUPER";
      "$menu" = "rofi -show drun -show-icons";
      "$screenshot-region" = "hyprshot -m region --clipboard-only";
      "$vol-down" = "pactl set-sink-volume @DEFAULT_SINK@ -5%";

      exec-once = [
        "dunst"
        "systemctl --user start hyprpolkitagent"
        #"swww-daemon" - Could also be used for wallpapers?
        "waybar"
        "kdeconnect-indicator"
        "nm-applet"
        "hyprpaper"
        "nm-applet & blueman-applet"
      ];

      bind = [
        "$mod, RETURN, exec, rofi -show drun"
        "$mod, Q, exec, $terminal"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, E, exec, $fileManager"
        "$mod, V, togglefloating"
        "$mod, R, exec, $menu"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod SHIFT, S, exec, $screenshot-region"
        "$mod SHIFT, PrintScreen, exec, $screenshot-window"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod, page_up, exec, $vol-up"
        "$mod, page_down, exec, $vol-down"
        "$mod ALT, right, resizeactive, 10 0"
        "$mod ALT, left, resizeactive, -10 0"
        "$mod ALT, up, resizeactive, 0 -10"
        "$mod ALT, down, resizeactive, 0 10"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, M, movetoworkspace, special:magic"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        "$mod, mouse:272, movewindow"
        # Volume keys using wpctl (PipeWire)
        ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
      ];

      windowrulev2 = [
        "float, class:org.pulseaudio.pavucontrol"
        "size 40% 40%, class:org.pulseaudio.pavucontrol"
        "move 60% 6%, class:org.pulseaudio.pavucontrol"
        "opacity 0.8, class:org.pulseaudio.pavucontrol"
      ];

      general = {
        gaps_out = 7.5;
        border_size = 1;
        resize_on_border = true;
      };

      decoration = {
        rounding = 5;
        rounding_power = 5;
        # Blur amt = blur_size * blur_passes (over 5 blurpasses produces artifacts tho)
        #blur = {
        #	enabled = true;
        #	size = 3;
        #	passes = 1;
        #	noise = 0.1;
        #};

        #inactive_opacity = 1;
        #active_opacity = 1;
      };

    };
  };
}
