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
      "network-online.target"
      "tailscaled.service"
    ];
    wants = [
      "network-online.target"
      "tailscaled.service"
    ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      Environment = "SOPS_AGE_KEY_FILE=${ageKeyFile}";
    };

    script = ''
      export HOME=/root

      # wait for tailscaled to settle
      for _ in $(seq 1 10); do
        if ${pkgs.tailscale}/bin/tailscale status -json >/dev/null 2>&1; then
          break
        fi
        sleep 1
      done

      status="$(${pkgs.tailscale}/bin/tailscale status -json 2>/dev/null | ${pkgs.jq}/bin/jq -r .BackendState 2>/dev/null || echo "")"
      if [ "$status" = "Running" ]; then
        exit 0
      fi

      authkey=tskey-auth-kj2Xo2jp7521CNTRL-FhYAPdKpRu17h8jRD1AHv1sCNBaJ8zKYL

      if [ -z "$authkey" ] || [ "$authkey" = "null" ]; then
        echo "tailscale-autoconnect: tailscale_secret is empty; skipping autoconnect"
        exit 0
      fi

      ${pkgs.tailscale}/bin/tailscale up -authkey "$authkey" || {
        echo "tailscale-autoconnect: tailscale up failed; skipping without failing boot"
        exit 0
      }
    '';
  };
}
