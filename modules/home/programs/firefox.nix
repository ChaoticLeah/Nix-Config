{ pkgs, inputs, ... }:
{
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = with pkgs; [ kdePackages.plasma-browser-integration ff2mpv-rust ];
    profiles = {
      "user" = {
        id = 0;
        isDefault = true;

        search = {
          force = true;
          default = "Leahs SearXNG Search Engine";
          engines = {
            "Leahs SearXNG Search Engine" = {
              definedAliases = [ "@leah" ];
              urls = [{
                template = "https://search.leahdevs.xyz";
                params = [
                  { name = "q"; value = "{searchTerms}"; }
                ];
              }];
            };
            "grep" = {
              definedAliases = [ "@grep" ];
              urls = [{
                template = "https://grep.app";
                params = [
                  { name = "q"; value = "{searchTerms}"; }
                ];
              }];
            };
          };
        };

        settings = {
          "accessibility.force_disabled" = 1;
          "app.normandy.api_url" = "";
          "app.normandy.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "apz.gtk.kinetic_scroll.enabled" = false;
          "apz.overscroll.enabled" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.contentblocking.category" = "strict";
          "browser.ctrlTab.recentlyUsedOrder" = false;
          "browser.discovery.enabled" = false;
          "browser.download.alwaysOpenPanel" = false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.newtabpage.enabled" = false;
          "browser.ping-centre.telemetry" = false;
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = "";
          "browser.search.suggest.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.startup.homepage" = "https://search.leahdevs.xyz";
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.startup.page" = 3;
          "browser.tabs.inTitlebar" = 0;
          "browser.theme.dark-private-windows" = true;
          "browser.urlbar.trimURLs" = false;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "cookiebanners.ui.desktop.enabled" = true;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "devtools.theme" = "dark";
          "devtools.toolbox.host" = "right";
          "dom.disable_window_move_resize" = true;
          "dom.security.https_only_mode" = true;
          # "dom.storage.next_gen" = true;
          "extensions.formautofill.heuristics.enabled" = false;
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "extensions.pocket.enabled" = false;
          "general.smoothScroll" = false;
          "gfx.webrender.all" = true;
          "media.memory_cache_max_size" = 65536;
          "network.auth.subresource-http-auth-allow" = 1;
          "network.gio.supported-protocols" = "";
          "network.http.referer.XOriginPolicy" = 2;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "network.protocol-handler.external.mailto" = false;
          "network.proxy.socks_remote_dns" = true;
          "permissions.delegation.enabled" = false;
          "privacy.sanitize.sanitizeOnShutdown" = false;
          "privacy.clearOnShutdown.cache" = false;
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.formdata" = true;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.sessions" = false;
          "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = false;
          "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "privacy.window.name.update.enabled" = true;
          "security.cert_pinning.enforcement_level" = 2;
          "security.mixed_content.block_display_content" = true;
          "security.OCSP.require" = true;
          "security.pki.crlite_mode" = 2;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.ssl.require_safe_negotiation" = true;
          "services.sync.engine.addons" = false;
          "services.sync.engine.creditcards" = false;
          "services.sync.engine.passwords" = false;
          "toolkit.coverage.endpoint.base" = "";
          "toolkit.coverage.opt-out" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "toolkit.scrollbox.smoothScroll" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "widget.non-native-theme.enabled" = true;
        };

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          plasma-integration
          ublock-origin
          web-scrobbler
          bitwarden
          copy-n-paste
          terms-of-service-didnt-read
        ];
      };
    };
    policies = {
      "ExtensionSettings" = {
        "uBlock0@raymondhill.net" = {
          private_browsing_allowed = true;
        };
      };
    };
  };
}
