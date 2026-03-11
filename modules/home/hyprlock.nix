{
  ...
}:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = false;
        ignore_empty_input = true;
      };

      animations = {
        enabled = true;
        fade_in = {
          duration = 1000;
          bezier = "easeOutQuint";
        };
        fade_out = {
          duration = 1000;
          bezier = "easeOutQuint";
        };
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
          noise = 0.021700;

          contrast = 0.891700;
          brightness = 0.500000;
          vibrancy = 0.168600;
          vibrancy_darkness = 0.050000;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          placeholder_text = "<span foreground=\"##cad3f5\">Password...</span>";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 80;
          font_family = "FiraCode Nerd Font";
          rotate = 0.000000;
          shadow_passes = 0;
          shadow_size = 3;
          shadow_color = "rgba(0, 0, 0, 1.0)";
          shadow_boost = 1.200000;
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "$LAYOUT";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 12;
          font_family = "FiraCode Nerd Font";
          rotate = 0.000000;
          shadow_passes = 0;
          shadow_size = 3;
          shadow_color = "rgba(0, 0, 0, 1.0)";
          shadow_boost = 1.200000;
          position = "0, -160";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}