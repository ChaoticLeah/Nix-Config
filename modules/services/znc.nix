{
  pkgs,
  config,
  ...
}:
{
  sops.secrets = {
    "znc_password" = {};
  };

  services.znc = {
    enable = true;
    mutable = true;
    useLegacyConfig = false;
    openFirewall = true;
  };
  
  # Set up ZNC config with secrets
  systemd.services.znc-setup = {
    description = "ZNC Configuration Setup";
    before = [ "znc.service" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    
    script = ''
      mkdir -p /var/lib/znc/configs
      
      ZNC_PASSWORD=$(cat ${config.sops.secrets."znc_password".path})
      
      cat > /var/lib/znc/configs/znc.conf <<EOF
      Version = 1.10.1
      
      <Listener 5000>
        IPv4 = true
        IPv6 = false
        Port = 5000
        SSL = true
      </Listener>
      
      LoadModule = adminlog
      
      <User leah>
        Admin = true
        Nick = chaoticleah
        AltNick = chaoticleah_
        RealName = Leah
        Buffer = 500
        AutoClearChanBuffer = false
        
        <Pass password>
          Method = plain
          Password = $ZNC_PASSWORD
        </Pass>
        
        <Network libera>
          Server = irc.libera.chat +6697
          Nick = chaoticleah
          JoinDelay = 2
          
          <Chan #nixos>
          </Chan>
          <Chan #meshcore>
          </Chan>
          <Chan #hackers.town>
          </Chan>
          <Chan #mcopen>
          </Chan>
        </Network>
      </User>
      EOF
      
      chown -R znc:znc /var/lib/znc
    '';
  };
}

