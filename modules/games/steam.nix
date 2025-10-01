{pkgs, ...}:
{
  # Steam
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
  };

  # Steam controller support
  services.udev.extraRules = ''
    # Steam controller support
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
    KERNEL=="uinput", MODE="0660", GROUP="users", OPTIONS+="static_node=uinput"
    # Steam Link support
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
    # HTC Vive HID Sensor naming and permissioning
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="2c87", MODE="0666"
  '';
}

