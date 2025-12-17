{ pkgs, inputs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles = {
      "user" = {
        id = 0;
        isDefault = true;

        search.engines = {
          "Nix Options" = {
            definedAliases = [ "@leah" ];
            urls = [{
              template = "https://search.leahdevs.xyz";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }];
          };
        };
        search.default = "Nix Options";

        settings = {
          "permissions.default.shortcuts" = 2;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.discoverystream.spocs.personalized" = false;
        };

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          plasma-integration
          ublock-origin
          web-scrobbler
          bitwarden
          copy-n-paste
        ];
      };
    };
  };
}
