{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;

    # WirePlumber configuration for USB audio devices
    wireplumber = {
      enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-usb-audio.conf" ''
          # Global settings for USB audio
          monitor.alsa.properties = {
            alsa.reserve = false
          }

          # USB device rules - matches by bus
          monitor.alsa.rules = [
            {
              matches = [
                {
                  device.bus = "usb"
                }
              ]
              actions = {
                update-props = {
                  api.alsa.period-size = 8192
                  api.alsa.period-num = 8
                  api.alsa.headroom = 32768
                  session.suspend-timeout-seconds = 0
                }
              }
            }
            # Specific rule for Razer Barracuda X
            {
              matches = [
                {
                  device.vendor.id = "0x1532"
                  device.product.id = "0x0536"
                }
              ]
              actions = {
                update-props = {
                  api.alsa.period-size = 8192
                  api.alsa.period-num = 8
                  api.alsa.headroom = 32768
                  api.alsa.disable-tsched = true
                  session.suspend-timeout-seconds = 0
                  # Prevent volume from going above 100% to avoid clipping
                  channelmix.normalize = false
                  channelmix.mix-lfe = false
                  audio.rate = 48000
                  audio.allowed-rates = [ 48000 ]
                }
              }
            }
            # Node rules for Razer output to limit volume
            {
              matches = [
                {
                  node.name = "~alsa_output.usb-Razer.*"
                }
              ]
              actions = {
                update-props = {
                  channelmix.normalize = false
                  channelmix.mix-lfe = false
                  node.force-quantum = 2048
                }
              }
            }
          ]
        '')
      ];
    };

    # Configuration for better USB audio support
    extraConfig.pipewire = {
      "context.properties" = {
        "link.max-buffers" = 16;
        "log.level" = 2;
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 48000 ];
        "default.clock.quantum" = 2048;
        "default.clock.min-quantum" = 2048;
        "default.clock.max-quantum" = 2048;
        "default.clock.force-quantum" = 2048;
      };

      "context.spa-libs" = {
        "audio.convert" = "audioconvert/libspa-audioconvert";
        "support.dbus" = "dbus/libspa-dbus";
      };

      "context.modules" = [
        {
          name = "libpipewire-module-rtkit";
          flags = [ "ifexists" "nofail" ];
          args = {
            "nice.level" = -15;
            "rt.prio" = 88;
            "rt.time.soft" = 200000;
            "rt.time.hard" = 200000;
          };
        }
        {
          name = "libpipewire-module-protocol-native";
        }
        {
          name = "libpipewire-module-profiler";
        }
        {
          name = "libpipewire-module-metadata";
        }
        {
          name = "libpipewire-module-spa-device-factory";
        }
        {
          name = "libpipewire-module-spa-node-factory";
        }
        {
          name = "libpipewire-module-filter-chain";
          args = {
            "audio.convert.channelmix.disable" = false;
          };
        }
        {
          name = "libpipewire-module-loopback";
          flags = [ "nofail" ];
        }
      ];
    };

    extraConfig.pipewire-pulse = {
      "pulse.properties" = { };
      "stream.properties" = {
        "pulse.min.req" = 2048;
        "pulse.min.quantum" = 2048;
        "pulse.max.req" = 2048;
        "pulse.max.quantum" = 2048;
        "resample.quality" = 10;
        "resample.disable" = false;
        "channelmix.normalize" = false;
        "channelmix.mix-lfe" = false;
      };
    };
  };

  # Disable USB autosuspend for audio devices to prevent dropouts
  services.udev.extraRules = ''
    # Prevent autosuspend on USB audio devices (Razer Barracuda X, etc)
    SUBSYSTEM=="usb", ATTRS{bInterfaceClass}=="01", ATTR{power/control}="on"
    # Disable autosuspend for Razer devices specifically
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1532", ATTR{power/control}="on"
  '';

  # Systemd service to ensure USB audio devices don't autosuspend
  systemd.services.disable-usb-audio-autosuspend = {
    description = "Disable USB autosuspend for audio devices";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.bash}/bin/bash -c 'for i in /sys/bus/usb/devices/*/power/control; do if [ -f $i ]; then echo on > $i 2>/dev/null || true; fi; done'";
    };
  };

  boot.kernelParams = [
    # Adjust USB autosuspend behavior for better audio stability
    "usbcore.autosuspend=1"
    "usbcore.autosuspend_delay_ms=30000"
  ];

  boot.extraModprobeConfig = ''
    # USB audio parameters for better latency and buffer management
    # Razer Barracuda X specific (vid=0x1532, pid=0x0536)
    options snd_usb_audio vid=0x1532 pid=0x0536 quirk_flags=0x20
  '';

  # Set CPU governor to performance for better audio stability
  powerManagement.cpuFreqGovernor = "performance";
}
