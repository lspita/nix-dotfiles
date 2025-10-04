{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./firefox.nix {
  options = {
    passwordManager.enable = utils.mkTrueEnableOption "firefox password manager";
  };
  config =
    { self, ... }:
    {
      programs.firefox = {
        enable = true;
        policies = {
          DisableTelemetry = true;
          OverrideFirstRunPage = "";
          NoDefaultBookmarks = true;
        }
        // (with self.passwordManager; {
          PasswordManagerEnabled = enable;
          OfferToSaveLogins = enable;
        });
        profiles.default = {
          name = "Default";
          isDefault = true;
          settings = {
            "sidebar.revamp" = true;
            "sidebar.verticalTabs" = true;
            "sidebar.visibility" = "always-show";
            "browser.uiCustomization.horizontalTabstrip" = [
              "tabbrowser-tabs"
              "new-tab-button"
            ];
            "devtools.toolbox.host" = "right";
            "browser.toolbarbuttons.introduced.sidebar-button" = true;
            "browser.toolbars.bookmarks.visibility" = "always";
            "browser.bookmarks.addedImportButton" = true;
            "browser.tabs.closeWindowWithLastTab" = false;
            "browser.download.open_pdf_attachments_inline" = true;
            # to fully apply, close and reopen after first startup
            "browser.uiCustomization.state" = {
              placements = {
                widget-overflow-fixed-list = [

                ];
                unified-extensions-area = [
                  "ublock0_raymondhill_net-browser-action"
                ];
                nav-bar = [
                  "sidebar-button"
                  "home-button"
                  "customizableui-special-spring1"
                  "vertical-spacer"
                  "back-button"
                  "forward-button"
                  "stop-reload-button"
                  "urlbar-container"
                  "fxa-toolbar-menu-button"
                  "downloads-button"
                  "customizableui-special-spring2"
                ]
                ++ (
                  if utils.isInstalled config "bitwarden-desktop" then
                    # pin bitwarden extension
                    [ "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" ]
                  else
                    [ ]
                )
                ++ [
                  "addon_darkreader_org-browser-action"
                  "unified-extensions-button"
                ];
                toolbar-menubar = [
                  "menubar-items"
                ];
                TabsToolbar = [

                ];
                vertical-tabs = [
                  "tabbrowser-tabs"
                ];
                PersonalToolbar = [
                  "personal-bookmarks"
                ];
              };
              seen = [ ];
              dirtyAreaCache = [ ];
              currentVersion = 23;
              newElementCount = 9;
            };
          };
        };
      };
    };
}
