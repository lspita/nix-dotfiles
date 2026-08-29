{ den, lib, ... }: {
  den.aspects.shell.bash.blesh = {
    shellrc = [
      (lib.mkBefore ''[[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none'')
      (lib.mkAfter "[[ ! \${BLE_VERSION-} ]] || ble-attach")
    ];

    homeManager = { pkgs, ... }: {
      home = { hasAspect, ... }: {
        packages = with pkgs; [ blesh ];
        file.".blerc".text =

          # https://github.com/akinomyoga/ble.sh/blob/master/blerc.template
          ''
            ${lib.strings.optionalString (hasAspect den.aspects.tool.fzf)
              # https://github.com/akinomyoga/ble.sh#fzf-integration
              ''
                # Note: If you want to combine fzf-completion with bash_completion, you need to
                # load bash_completion earlier than fzf-completion.  This is required
                # regardless of whether to use ble.sh or not.
                # source /etc/profile.d/bash_completion.sh

                ble-import -d integration/fzf-completion
                ble-import -d integration/fzf-key-bindings
              ''
            }

            # Disable auto-menu without tab
            bleopt complete_auto_menu=
          '';
      };
    };
  };
}
