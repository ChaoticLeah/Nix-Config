{ pkgs, ... }: 
{
    #hardware.opentabletdriver.enable = true;
    
    #services.udev.extraRules = ''
    #SUBSYSTEM=="usb", ATTRS{idVendor}=="0416", ATTRS{idProduct}=="3f00", MODE="0666"
    #'';


    services.xserver.wacom.enable = true;

}

