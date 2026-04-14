# Isaac's NixOS Configuration

This is my personal NixOS configuration using Nix Flakes. It's designed for a laptop setup with Hyprland(Caelestia) and Plasma as a backup.

## Showcase
Here you can find screenshots or descriptions of how your NixOS configuration looks and feels:

> [!NOTE]
> Screenshots and visual demonstrations are not currently available. They will be added once the "ricing" is complete.

### Highlights
- **Hyprland**: Smooth workspace layouts and custom animations.
- **Plasma Desktop**: Stable backup environment.
- **Terminal**: Starship prompt with custom themes.
- **[Caelestia Shell](https://github.com/caelestia-dots/shell)**: Enhanced user experience and aesthetics.

## System Overview
- **Base System**: NixOS unstable channel.
- **Init**: Systemd with Secure Boot (via Lanzaboote).
- **DE/WM**: Hyprland ([Caelestia]((https://github.com/caelestia-dots/shell)) & KDE Plasma.
- **File System**: Btrfs with Snapper & Auto-Scrub.
- **Additional Services**: Bluetooth, PipeWire (Audio), Warp VPN and Priting support.
- **Package Management**: Flakes + Home Manager.

## Directory Structure

```
.
├── flake.nix          # Main flake configuration
├── flake.lock         # Locked dependencies
├── hosts/             # Host-specific configurations
│   └── laptop/        # Laptop host configuration
├── home/              # Home directory configurations
├── modules/           # NixOS modules
│   ├── desktop/       # Desktop environment configurations
│   ├── hardware/      # Hardware-specific modules
│   ├── programs/      # Program-specific configurations
│   ├── services/      # System services
│   ├── system/        # Core system modules
│   └── users/         # User-specific configurations
├── packages/          # Custom packages
└── README.md          # This file
```

## Features

### Development Environment
Ready-to-use stack for modern development:
- **Framework**: .NET SDK, Java, Node.Js, Bun.
- **Database**: PostgreSQL service.
- **Compatibility**: `nix-ld` enabled for unpatched non-Nix binaries.
- **Shell**: Zsh (default shell) as essential CLI utilities.
- Essential development tools

### Desktop Environment
- Hyprland with custom animations and keybindings (primary)
- Plasma desktop (backup)
- SDDM display manager
- Starship prompt for enhanced terminal experience
- Caelestia Shell integration

### System Resilience
- **Btrfs**: Optimized with `zstd` compression and `noatime`.
- **Snapper**: Configured for root and home subvolumes (manual snapshots ready).
- **Flatpak & AppImage**: Full support for universal Linux packages.

### Secure Boot & Bootloader
- **Lanzaboote**: Integrated for full Secure Boot support.
- **PKI Management**: Bundles are handled at `/var/lib/sbctl`.
- **Visuals**: Eye-candy boot experience using **Plymouth** (`adi1090x` themes).

## Installation

1. Clone this repository to `/etc/nixos`.
2. Create a new directory in hosts/<your-hostname> and copy your hardware-configuration.nix there.
3. Run `nixos-rebuild switch --flake .#nixosConfigurations.nixos`.
4. For initial installation, you may need to configure hardware-specific settings first.

## Configuration

### Host-Specific Settings
Laptop-specific configurations are in `hosts/laptop/` including:
- `configuration.nix`: Main system configuration
- `hardware-configuration.nix`: Hardware detection results

### User Settings
User-specific configurations managed by Home Manager are in:
- `home/isaac.nix`: Main Home Manager configuration
- `home/isaac/programs/`: Program-specific configurations
- `modules/users/isaac.nix`: NixOS user configuration

### Modules
Custom NixOS modules are organized in the `modules/` directory:
- System modules (boot, networking, locale, etc.)
- Desktop environment modules (Plasma, SDDM, Hyprland)
- Hardware modules (Intel-specific configurations)
- Service modules (audio, bluetooth, printing, etc.)
- Program modules (development tools, databases, etc.)

## Custom Packages
Located in the `packages/` directory:
- `base.nix`: Essential system packages
- `fonts.nix`: Custom font collection

## Maintenance

To update the system:
```bash
# Update flake inputs
nix flake update

# Rebuild system
sudo nixos-rebuild switch --flake .#nixosConfigurations.nixos

# Update home configuration
home-manager switch --flake .#isaac
```

## License
See the [LICENSE](LICENSE) file for details.