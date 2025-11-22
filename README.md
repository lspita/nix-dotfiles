# ❄️ Nix dotfiles

This is my nix + [home manager](https://github.com/nix-community/home-manager) configuration shared between different machines and systems.

> [!important]
> While it is modular and configurable, it's still meant to be my personal configuration and not something anyone can grab and use without touching anything.

> [!important]
> [nix-darwin](https://github.com/nix-darwin/nix-darwin) is included in the flake for macos support and the modules are splitted based on what is cross-platform and what not, but since I don't have a mac, it was never tested.

## Structure

- `vars.nix`: variables used all across the configuration.
- `modules`: directory with all the configuration modules. These modules options are available under the `custom` option in the corresponding configuration.
  - `system`: directory with modules available in the system configuration.
  - `home`: directory with modules available in the home manager configuration.
- `hosts`: directory with host configurations. Each top-level directory inside it is a hostname and contains the specific config files for that machine.
  - `hardware.nix`: REQUIRED hardware configuration of the host.
  - `info.nix`: REQUIRED host details.
  - `system.nix`: system configuration.
  - `home.nix`: home manager configuration.
  - `vars.nix`: host `vars.nix` overrides.
  - `modules`: directory with all the host-specific configuration modules. These modules options are available under the `custom.hostModules` option in the corresponding configuration. It is structured just like the top-level `modules` directory.
- `lib`: directory with user defined library. The library is loaded with [haumea](https://github.com/nix-community/haumea) and provided under `lib.custom`.
- `assets`: directory with different type of assets:
  - `wallpapers`: directory with wallpapers. A wallpaper can either be a single file or a directory containing a `light` and `dark` variant.
  - `profiles`: directory with user profile pictures.
- `outputs`: directory with the flake outputs.
- `templates`: directory with templates provided by this flake
- `overlays`: directory with overlays to use for the nix packages.
