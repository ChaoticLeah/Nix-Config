{ pkgs, ... }:

let
  secretsFile = "/etc/nixos/secrets.yaml";
  ageKeyFile = "/etc/age/keys.txt";
in
{
  services.tailscale.enable = true;

  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    after = [
      "network-pre.target"
      "tailscale.service"
    ];
    wants = [
      "network-pre.target"
      "tailscale.service"
    ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      Environment = "SOPS_AGE_KEY_FILE=${ageKeyFile}";
    };

    script = ''
      export HOME=/root

      # wait for tailscaled to settle
      sleep 2

      status="$(${pkgs.tailscale}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)"
      if [ "$status" = "Running" ]; then
        exit 0
      fi

      authkey=tskey-auth-kj2Xo2jp7521CNTRL-FhYAPdKpRu17h8jRD1AHv1sCNBaJ8zKYL

      ${pkgs.tailscale}/bin/tailscale up -authkey "$authkey"
    '';
  };
}
