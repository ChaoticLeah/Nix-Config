{ pkgs, config, ... }:
{
  services.tailscale.enable = true;

  sops.secrets."tailscale_secret" = { };

  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    after = [ "network-pre.target" "tailscale.service" "sops-install-secrets.service" ];
    wants = [ "network-pre.target" "tailscale.service" "sops-install-secrets.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";

    script = ''
      export HOME=/root

      # wait for tailscaled to settle
      sleep 2

      status="$(${pkgs.tailscale}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)"
      if [ "$status" = "Running" ]; then
        exit 0
      fi

      authkey="$(${pkgs.coreutils}/bin/tr -d '\r\n' < ${config.sops.secrets."tailscale_secret".path})"

      ${pkgs.tailscale}/bin/tailscale up -authkey "$authkey"
    '';
  };
}
