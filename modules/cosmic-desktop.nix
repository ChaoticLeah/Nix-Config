{
  globals,
  inputs,
  pkgs,
  lib,
  config,
  hostName,
  ...
}:
{
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # Some mysterious preformance gains according to the docs lol
  services.system76-scheduler.enable = true;

  # Make it so any app not in focus can also access clipboard
  # environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  home-manager.users.${globals.user} = {
    # imports = [ inputs.nixos-cosmic.homeManagerModules.default ];

    # 3. Define the shortcuts using the now-available COSMIC options
    # wayland.desktopManager.cosmic.shortcuts = [
    #   {
    #     action = { variant = "Launcher"; };
    #     description = "Open App Launcher";
    #     key = "Super+Return";
    #   }
    #   {
    #     action = { variant = "Spawn"; value = [ "cosmic-term" ]; };
    #     description = "Launch Terminal";
    #     key = "Super+Q";
    #   }
    #   {
    #     action = { variant = "CloseWindow"; };
    #     description = "Close Window";
    #     key = "Super+Shift+Q";
    #   }
    # ];

    # Install some COSMIC applications
    home.packages = with pkgs; [
      cosmic-edit
      cosmic-files
      cosmic-term
    ];

    # Configure dconf for COSMIC applications
    dconf.settings = {
      "com/system76/CosmicEdit" = {
        app-theme = "System";
        font-name = "Fira Mono 14";
        line-numbers = true;
        syntax-theme-dark = "COSMIC Dark";
        syntax-theme-light = "COSMIC Light";
      };
      
      "com/system76/CosmicFiles" = {
        app-theme = "System";
        show-details = false;
      };
      
      "com/system76/CosmicTerm" = {
        app-theme = "System";
        font-name = "Fira Mono 12";
        opacity = 100;
      };

      # Display settings - 100% scale on all outputs
      "com/system76/CosmicSettings/displays" = {
        scale = 1.0;
      };

      # Custom keybinding: Super+Enter opens COSMIC search/launcher
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/cosmic-search/"
        ];
      };

      # System font (via GNOME interface schema until COSMIC exposes its own)
      "org/gnome/desktop/interface" = {
        font-name = lib.mkForce "Fira Mono 12";
        document-font-name = "Fira Mono 12";
        monospace-font-name = "Fira Mono 12";
      };

      # Dock autohide (dash-to-dock)
      "org/gnome/shell/extensions/dash-to-dock" = {
        autohide = true;
        dock-fixed = false;
      };

      # GNOME-specific dconf tweaks removed; COSMIC ships its own shell and panels.
    };
  };
}


