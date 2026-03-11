{ pkgs, config, inputs, globals, ... }:
let
  passwordPath = config.sops.secrets.znc_password.path;

  weechatConfig = pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      plugins = with availablePlugins; [ python perl ];
      scripts = [ ];
      init = ''
        /server add znc localhost/5000 -notls
        /set irc.server.znc.autoconnect on
        /set irc.server.znc.nicks "chaoticleah"
        /set irc.server.znc.username "chaoticleah"
      '';
    };
  };
in
{
  # sops.secrets.znc_password = {};

  home.packages = [ weechatConfig ];
  
  home.file.".local/bin/weechat-start" = {
    executable = true;
    text = ''
      #!/bin/sh
      # 3. Read the secret at runtime from the decrypted sops path
      if [ ! -f "${passwordPath}" ]; then
        echo "Secret not found at ${passwordPath}. Is sops-nix running?"
        exit 1
      fi

      ZNC_PASS=$(cat "${passwordPath}")
      
      # Start weechat and inject the password command
      exec ${weechatConfig}/bin/weechat \
        -r "/set irc.server.znc.password $ZNC_PASS; /connect znc" "$@"
    '';
  };
}