{ ... }:
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
      };
    };
  };
}
