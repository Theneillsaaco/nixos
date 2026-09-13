# Isaac's NixOS Configuration

A personal, multi-host NixOS configuration using Flakes, featuring Hyprland with [Caelestia Shell](https://github.com/caelestia-dots/shell) as the primary desktop environment and KDE Plasma as a backup/coexisting session.

## Showcase

Here you can find screenshots or descriptions of how your NixOS configuration looks and feels:

> [!NOTE]
> Screenshots and visual demonstrations are not currently available. They will be added once the "ricing" is complete.

### Visual Highlights
- **Hyprland Workspaces**: Smooth animations between workspaces and windows
- **Window Decorations**: Custom borders, shadows, and transparency effects
- **Terminal Appearance**: Starship prompt with color schemes and information density
- **Application Launchers**: Custom menus and keybindings for rapid access
- **Desktop Effects**: Compositing, blur, and visual feedback enhancements
- **Boot Experience**: Secure boot process with animated Plymouth theme

## Hosts
This flake defines two machines, each with its own hardware profile:

| Host     | Machine                          | CPU/Platform notes                          | Boot / Disk security                   |
|----------|-----------------------------------|----------------------------------------------|------------------------------------------|
| `hp`     | HP laptop (older)                | Intel i5-7200U                               | Standard boot                            |
| `lenovo` | Lenovo laptop actual             | AMD Ryzen 7 5825U, btrfs swapfile hibernation | **Secure Boot (Lanzaboote) + TPM2-backed LUKS auto-unlock** |

Rebuild/boot commands are host-aware: the `rebuild`/`boot`/`upgrade` shell aliases resolve to the correct flake target (`#hp` or `#lenovo`) automatically based on which machine you're on, so the same dotfiles work unmodified across hosts. 

## System Overview

- **Base System**: NixOS unstable channel, Flakes + Home Manager
- **Init**: Systemd with Secure Boot (via Lanzaboote)
- **Display Server**: Hyprland ([Caelestia Shell](https://github.com/caelestia-dots/shell)) / Plasma fallback
- **Display Manager**: Plasma Login Manager
- **File System**: Btrfs with zstd compression, Snapper snapshots, and auto-scrub
- **Shell**: Zsh with Starship prompt
- **Keyring**: KDE Wallet (KWallet)
- **Additional Services**: Bluetooth, PipeWire (audio), Warp VPN, Printing, firejail sandboxing for select GUI apps
- **Development**: .NET SDK, Java, PostgreSQL, Node.js/Bun, Arduino, general C/C++ toolchain and essential dev tools
- **Security**: LUKS full-disk encryption, Secure Boot + TPM2 auto-unlock 
- **Universal Package Support**: Flatpak & AppImage

## Directory Structure

```
.
├── flake.nix                  # Main flake configuration (defines hp + lenovo hosts)
├── flake.lock                 # Locked dependency versions
├── lib/
│   └── importModules.nix      # importDir helper: auto-imports *.nix files in a directory (non-recursive)
├── hosts/
│   ├── common.nix             # Shared host-level settings (unfree, zsh, flatpak, appimage, gamemode, etc.)
│   └── laptop/
│       ├── hp/                # HP host: configuration.nix + hardware-configuration.nix
│       └── lenovo/             # Lenovo/Ryzen host: configuration.nix + hardware-configuration.nix
├── home/
│   ├── isaac.nix               # Main Home Manager entrypoint
│   └── isaac/
│       ├── config/             # Per-program HM configs (zsh, git, kitty, foot, starship, xdg, direnv)
│       └── programs/           # HM program modules (Hyprland, Caelestia, dev tools, desktop apps)
│           ├── hyprland/        # Hyprland module + Lua config (keybinds, execs, vars)
│           ├── old/             # Retired/experimental configs kept for reference (not auto-imported)
│           └── ...
├── modules/
│   ├── system/                 # Boot, networking, locale, swap, wifi, nix settings, btrfs
│   ├── desktop/                 # Hyprland, Plasma 6, Plasma Login Manager
│   ├── hardware/                # amd.nix / intel.nix per-platform driver & power tuning
│   ├── services/                # audio, bluetooth, printing, ssh, keyring, firejail, warp
│   ├── programs/                # java, postgres, steam, gaming, devtools, nh, nix-ld
│   ├── users/                   # User account definitions
│   ├── optional/                # Opt-in modules explicitly imported by a host (e.g. tpm-unlock.nix)
│   └── deprecated/               # Modules kept for later reactivation, not auto-imported
├── packages/                    # base.nix, fonts.nix — systemPackages assembled via importDir
├── LICENSE
└── README.md
```

## Features

### Desktop Environment
- **Hyprland**: Tiling Wayland compositor, launched via UWSM. Keybindings, exec hooks, and variables are written directly in Lua (`extraLuaFiles`, `configType = "lua"`) rather than generated from Nix — this keeps non-trivial Hyprland config (the Caelestia `hl.*` API) readable and easy to iterate on. Simple declarative settings (monitors, env vars, general/decoration blocks) stay in Nix.
- **[Caelestia Shell](https://github.com/caelestia-dots/shell)**: Compositor shell layer — bar, launcher, dashboard, notifications, session menu.
- **KDE Plasma 6**: Full desktop environment coexisting with Hyprland. Qt theming for apps launched from Hyprland is set explicitly via `QT_QPA_PLATFORMTHEME` in `hyprland.settings.env` (Home Manager's `sessionVariables`/`.profile` are never sourced by UWSM-launched sessions).
- **Plasma Login Manager**: Display manager, replacing SDDM.
- **Starship Prompt**: Cross-shell prompt with rich, host-agnostic customization.

### Security
- **Secure Boot (Lenovo)**: Enabled via Lanzaboote, keys enrolled with `sbctl --microsoft` to preserve Windows/BitLocker dual-boot compatibility.
- **TPM2 LUKS auto-unlock (Lenovo)**: `systemd-cryptenroll` with PCRs `0+2+7+12`; isolated in `modules/optional/tpm-unlock.nix` so it never leaks into other hosts via `importDir`.
- **KWallet / Secret Service**: `ksecretd` backs the Secret Service API; `kwalletd6` handles native KWallet format (used by NetworkManager for WiFi credentials, which are kept encrypted rather than stored in plaintext connection files).
- **LUKS + Btrfs**: Root and home encrypted, with Snapper timeline/number-based snapshot cleanup and monthly auto-scrub.

### Development Environment
- **.NET SDK, Java (JDK 17/21/25), Node.js & Bun, PostgreSQL 18**
- **Arduino IDE/CLI, general C/C++ toolchain (gcc, cmake, ninja)**
- **Compatibility Layer**: `nix-ld` for running unpatched non-Nix binaries
- **Editors**: VS Code, Zed, JetBrains Toolbox

### System Services
- **Audio**: PipeWire with PulseAudio and JACK compatibility
- **Bluetooth**: Full stack with GUI management (Blueman)
- **Printing**: CUPS
- **Networking**: NetworkManager, resolved with DNSSEC + fallback DNS
- **VPN**: Cloudflare Warp with helper `warp-on`/`warp-off` scripts
- **Sandboxing**: Firejail-wrapped GUI apps (browsers, chat clients, office suite)
- **Flatpak & AppImage**: Universal Linux package support

### User Environment (Home Manager)
- **Shell**: Zsh with plugins, Starship, direnv, host-aware `rebuild`/`boot`/`upgrade` aliases
- **Git, Kitty, Foot, XDG defaults** pre-configured per-program under `home/isaac/config/`
- **Caelestia CLI & theming** configured declaratively (appearance, bar, notifications, idle behavior)


## Installation
 
1. **Clone the repository**:
```bash
   git clone https://github.com/Theneillsaaco/nixos /etc/nixos
   cd /etc/nixos
```
 
2. **Prepare host configuration** (only needed when adding a new machine):
```bash
   mkdir -p hosts/laptop/<your-hostname>
   cp /etc/nixos-generated/hardware-configuration.nix hosts/laptop/<your-hostname>/
```
   Then add a new host entry in `flake.nix` following the existing `hp`/`lenovo` pattern.
 
3. **Build and switch to an existing configuration**:
```bash
   sudo nixos-rebuild switch --flake .#hp      # HP laptop
   sudo nixos-rebuild switch --flake .#lenovo  # Lenovo/Ryzen laptop
```
   Once inside a shell on the target machine, the `rebuild` alias does this for you automatically, pointed at the correct host.
 

## Configuration

### Host-Specific Settings
Each host under `hosts/laptop/<name>/` contains only what's genuinely host-specific:
- `configuration.nix`: hardware module imports, disk/hibernation params, `stateVersion`
- `hardware-configuration.nix`: auto-generated hardware detection (do not edit manually)
Shared host-level defaults (unfree packages, zsh, flatpak, appimage, gamemode, `NIXOS_OZONE_WL`) live in `hosts/common.nix` and are imported by every host — this is what keeps individual host files minimal.
 
### User Settings
- `home/isaac.nix`: Main Home Manager entrypoint (imports + shared packages)
- `home/isaac/config/` and `home/isaac/programs/`: per-program Home Manager modules, auto-imported via `myLib.importDir`
- `modules/users/isaac.nix`: NixOS user account and group membership
### Modules Organization
- **System**: Boot, networking, locale, swap, WiFi, Nix settings, Btrfs/Snapper
- **Desktop**: Window managers, display managers, desktop environments
- **Hardware**: Platform-specific drivers and power management (`amd.nix`, `intel.nix`)
- **Services**: Daemons and system services (audio, bluetooth, printing, keyring, SSH, VPN, sandboxing)
- **Programs**: Development tools, applications, language runtimes
- **Optional**: Opt-in modules a host must explicitly import (e.g. TPM unlock) — never picked up automatically, to avoid affecting hosts that don't need them

## Custom Packages

Located in the `packages/` directory:
- `base.nix`: Essential system packages and utilities
- `fonts.nix`: Custom font collection

## Maintenance

### Regular Updates
```bash
update    # sudo nix flake update --flake /etc/nixos
rebuild   # nh os switch /etc/nixos#<current-host>
boot      # nh os boot /etc/nixos#<current-host>
upgrade   # update && rebuild
```

### Garbage Collection
```bash
# Handled automatically via programs.nh.clean (daily, --keep-since 7d --keep 5)
# Manual alternative:
sudo nix-collect-garbage -d
sudo nix-store --optimize
```

### Backup & Recovery
```bash
# List available snapshots
sudo snapper list
 
# Create manual snapshot
sudo snapper -c root create --description "Pre-update snapshot"
 
# Rollback to snapshot (replace <NUM> with snapshot number)
sudo snapper -c root rollback <NUM>
```

## Known Loose Ends
- `modules/deprecated/` and `home/isaac/programs/old/` are intentionally kept (not auto-imported) as a holding area for configs that might be revived on another host later; they'll be deleted outright if unused for long enough.

## License

See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- NixOS community for the incredible ecosystem
- Caelestia-dots team for the beautiful shell themes
- Hyprland developers for the innovative Wayland compositor
- All contributors to the open-source software used in this configuration
