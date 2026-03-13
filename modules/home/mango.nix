{ pkgs, lib, config, osConfig, ... }:
let
  mod = "SUPER";
in{
  imports = [
    ./waybar/waybar.nix
    ./hyprlock.nix
  ];
  wayland.windowManager.mango = {
    enable = true;
    settings = ''
      # More option see https://github.com/DreamMaoMao/mango/wiki/

      # Window effect
      blur=0
      blur_layer=0
      blur_optimized=1
      blur_params_num_passes = 2
      blur_params_radius = 5
      blur_params_noise = 0.02
      blur_params_brightness = 0.9
      blur_params_contrast = 0.9
      blur_params_saturation = 1.2

      shadows = 0
      layer_shadows = 0
      shadow_only_floating = 1
      shadows_size = 10
      shadows_blur = 15
      shadows_position_x = 0
      shadows_position_y = 0
      shadowscolor= 0x000000ff

      border_radius=6
      no_radius_when_single=0
      focused_opacity=1.0
      unfocused_opacity=1.0

      # Animation Configuration(support type:zoom,slide)
      # tag_animation_direction: 1-horizontal,0-vertical
      animations=1
      layer_animations=1
      animation_type_open=slide
      animation_type_close=slide
      animation_fade_in=1
      animation_fade_out=1
      tag_animation_direction=1
      zoom_initial_ratio=0.3
      zoom_end_ratio=0.8
      fadein_begin_opacity=0.5
      fadeout_begin_opacity=0.8
      animation_duration_move=500
      animation_duration_open=400
      animation_duration_tag=350
      animation_duration_close=800
      animation_duration_focus=0
      animation_curve_open=0.46,1.0,0.29,1
      animation_curve_move=0.46,1.0,0.29,1
      animation_curve_tag=0.46,1.0,0.29,1
      animation_curve_close=0.08,0.92,0,1
      animation_curve_focus=0.46,1.0,0.29,1
      animation_curve_opafadeout=0.5,0.5,0.5,0.5
      animation_curve_opafadein=0.46,1.0,0.29,1

      # Scroller Layout Setting
      scroller_structs=20
      scroller_default_proportion=0.9
      scroller_focus_center=0
      scroller_prefer_center=0
      edge_scroller_pointer_focus=1
      scroller_default_proportion_single=1.0
      scroller_proportion_preset=0.5,0.8,1.0

      # Master-Stack Layout Setting
      new_is_master=1
      default_mfact=0.55
      default_nmaster=1
      smartgaps=0

      # Overview Setting
      hotarea_size=10
      enable_hotarea=1
      ov_tab_mode=0
      overviewgappi=5
      overviewgappo=30

      # Misc
      no_border_when_single=1
      axis_bind_apply_timeout=100
      focus_on_activate=1
      idleinhibit_ignore_visible=0
      sloppyfocus=1
      warpcursor=1
      focus_cross_monitor=0
      focus_cross_tag=0
      enable_floating_snap=0
      snap_distance=30
      cursor_size=24
      drag_tile_to_tile=1
      syncobj_enable=1

      # keyboard
      repeat_rate=25
      repeat_delay=600
      numlockon=0
      xkb_rules_layout=${osConfig.services.xserver.xkb.layout or "us"}

      # Trackpad
      # need relogin to make it apply
      disable_trackpad=0
      tap_to_click=1
      tap_and_drag=1
      drag_lock=1
      trackpad_natural_scrolling=0
      disable_while_typing=1
      left_handed=0
      middle_button_emulation=0
      swipe_min_threshold=1

      # mouse
      # need relogin to make it apply
      mouse_natural_scrolling=0

      # Appearance
      gappih=2
      gappiv=2
      gappoh=2
      gappov=2
      scratchpad_width_ratio=0.8
      scratchpad_height_ratio=0.9
      borderpx=4
      rootcolor=0x201b14ff
      bordercolor=0x444444ff
      focuscolor=0x89aa61ff
      # focuscolor={rgbToHex palette.{config.catppuccin.accent}.rgb}
      maximizescreencolor=0x89aa61ff
      urgentcolor=0xad401fff
      scratchpadcolor=0x516c93ff
      globalcolor=0xb153a7ff
      overlaycolor=0x14a57cff

      exec-once=swaynotificationcenter
      exec-once=nm-applet
      exec-once=kdeconnect-indicator
      exec-once=${pkgs.lib.getExe config.programs.waybar.package}
      exec=${pkgs.lib.getExe pkgs.swaybg} -m fill -i ${./wallpapers/wallpaper1.png}

      # layout support:
      # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
      tagrule=id:1,layout_name:scroller
      tagrule=id:2,layout_name:tile
      tagrule=id:3,layout_name:tile
      tagrule=id:4,layout_name:tile
      tagrule=id:5,layout_name:tile
      tagrule=id:6,layout_name:tile
      tagrule=id:7,layout_name:tile
      tagrule=id:8,layout_name:tile
      tagrule=id:9,layout_name:tile

      # Key Bindings
      # key name refer to `xev` or `wev` command output,
      # mod keys name: super,ctrl,alt,shift,none

      # reload config
      bind=${mod}+ctrl,r,reload_config


      bind=${mod},r,spawn,${pkgs.lib.getExe pkgs.rofi} -show drun
      bind=${mod},Return,spawn,${pkgs.lib.getExe pkgs.rofi} -show drun
      bind=${mod},q,spawn,${pkgs.lib.getExe pkgs.alacritty}
      bind=${mod},c,killclient,
      bind=${mod},l,spawn,${pkgs.lib.getExe config.programs.hyprlock.package}
      bindl=NONE,code:256,spawn,pactl set-source-mute @DEFAULT_SOURCE@ toggle
      bindl=NONE,code:121,spawn,pactl set-sink-mute @DEFAULT_SINK@ toggle
      bindl=NONE,code:122,spawn,pactl set-sink-volume @DEFAULT_SINK@ -5%
      bindl=NONE,code:123,spawn,pactl set-sink-volume @DEFAULT_SINK@ +5%
      bindl=NONE,XF86AudioLowerVolume,spawn,pactl set-sink-volume @DEFAULT_SINK@ -5%
      bindl=NONE,XF86AudioRaiseVolume,spawn,pactl set-sink-volume @DEFAULT_SINK@ +5%
      bind=NONE,code:107,spawn,${pkgs.lib.getExe pkgs.hyprshot}  --clipboard-only -z -m region
      bind=${mod}+SHIFT,s,spawn,${pkgs.lib.getExe pkgs.hyprshot} --clipboard-only -z -m region

      # Lid switch actions
      switchbind=fold,spawn,${pkgs.lib.getExe config.programs.hyprlock.package}

      # exit
      bind=${mod},m,quit

      # switch window focus
      bind=${mod},Tab,focusstack,next
      bind=${mod},h,focusdir,left
      bind=${mod},l,focusdir,right
      bind=${mod},k,focusdir,up
      bind=${mod},j,focusdir,down

      # swap window
      bind=${mod}+CTRL,k,exchange_client,up
      bind=${mod}+CTRL,j,exchange_client,down
      bind=${mod}+CTRL,h,exchange_client,left
      bind=${mod}+CTRL,l,exchange_client,right

      # switch window status
      bind=${mod},g,toggleglobal,
      bind=${mod},Tab,toggleoverview,
      bind=${mod},backslash,togglefloating,
      bind=${mod},a,togglemaximizescreen,
      bind=${mod},f,togglefullscreen,
      bind=${mod}+SHIFT,f,togglefakefullscreen,
      bind=${mod},i,minimized,
      bind=${mod},o,toggleoverlay,
      bind=${mod}+SHIFT,I,restore_minimized
      bind=${mod},z,toggle_scratchpad

      # scroller layout
      bind=${mod},e,set_proportion,1.0
      bind=${mod},x,switch_proportion_preset,

      # switch layout
      bind=${mod},n,switch_layout

      # tag switch
      # bind=${mod},h,viewtoleft,0
      # bind=${mod},l,viewtoright,0
      #bind=CTRL,h,viewtoleft_have_client,0
      #bind=CTRL,l,viewtoright_have_client,0
      #bind=CTRL+${mod},h,tagtoleft,0
      #bind=CTRL+${mod},l,tagtoright,0

      # tag: move client to the tag and focus it
      # tagsilent: move client to the tag and not focus it
      ${lib.concatStringsSep "\n" (lib.concatMap (num: [
        "bind=${mod},${toString num},view,${toString num},0"
        "bind=${mod}+Shift,${toString num},tag,${toString num},0"
      ]) [1 2 3 4 5 6 7 8 9])}

      # monitor switch
      bind=${mod}+shift,h,focusmon,left
      bind=${mod}+shift,l,focusmon,right
      # bind=${mod}+${mod},h,tagmon,left
      # bind=${mod}+${mod},l,tagmon,right

      # gaps
      bind=${mod}+SHIFT,X,incgaps,1
      bind=${mod}+SHIFT,Z,incgaps,-1
      bind=${mod}+SHIFT,R,togglegaps

      # movewin
      #bind=CTRL+SHIFT,k,movewin,+0,-50
      #bind=CTRL+SHIFT,j,movewin,+0,+50
      #bind=CTRL+SHIFT,h,movewin,-50,+0
      #bind=CTRL+SHIFT,l,movewin,+50,+0

      # resizewin
      #bind=CTRL+${mod},k,resizewin,+0,-50
      #bind=CTRL+${mod},j,resizewin,+0,+50
      #bind=CTRL+${mod},h,resizewin,-50,+0
      #bind=CTRL+${mod},l,resizewin,+50,+0

      # Mouse Button Bindings
      # btn_left and btn_right can't bind none mod key
      mousebind=${mod},btn_left,moveresize,curmove
      mousebind=${mod},btn_middle,togglemaximizescreen,0
      mousebind=${mod},btn_right,moveresize,curresize

      # Axis Bindings
      axisbind=${mod},UP,viewtoleft_have_client
      axisbind=${mod},DOWN,viewtoright_have_client

      # layer rule
      layerrule=animation_type_open:zoom,layer_name:rofi
      layerrule=animation_type_close:zoom,layer_name:rofi

      # Monitor rules
      ## vertical work monitor
      # monitorrule=serial:H4ZRA03650,rr:1,vrr:0 
      # monitorrule=serial:H4ZRA03652,rr:0,vrr:0

    '';
  };

  # xdg.configFile."mango/config.conf".text = mangoConfig;

  home.packages = with pkgs; [
    wlr-randr
  ];

  nixpkgs.config = { allowUnfree = true; };
}
