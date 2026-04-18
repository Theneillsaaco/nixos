[![NixOS Build & Cache](https://github.com/Theneillsaaco/nixos/actions/workflows/buildCache.yml/badge.svg)](https://github.com/Theneillsaaco/nixos/actions/workflows/buildCache.yml)

[![Cachix Cache](https://img.shields.io/badge/cachix-theneillsaaco--nix-blue.svg)](https://theneillsaaco-nix.cachix.org)

# Isaac's NixOS Configuration

A personal NixOS configuration using Flakes, featuring Hyprland with [Caelestia Shell](https://github.com/caelestia-dots/shell) as the primary desktop environment and KDE Plasma as a backup.

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

## System Overview

- **Base System**: NixOS unstable channel
- **Init**: Systemd with Secure Boot (via Lanzaboote)
- **Display Server**: Hyprland ([Caelestia Shell](https://github.com/caelestia-dots/shell)) / Plasma fallback
- **File System**: Btrfs with zstd compression, Snapper snapshots, and auto-scrub
- **Window Managers**: Hyprland (primary), KDE Plasma (backup)
- **Display Manager**: SDDM
- **Shell**: Zsh with Starship prompt
- **Package Management**: Nix Flakes + Home Manager
- **Keyring**: KDE Wallet (KWallet)
- **Additional Services**: Bluetooth, PipeWire (audio), Warp VPN, Printing
- **Development**: .NET SDK, Java, PostgreSQL, Node.js, Bun, essential dev tools
- **Hardware**: Intel-specific optimizations
- **Universal Package Support**: Flatpak & AppImage

## Directory Structure

```
.
├── flake.nix              # Main flake configuration
├── flake.lock             # Locked dependency versions
├── hosts/                 # Host-specific configurations
│   └── laptop/            # Laptop host configuration
├── home/                  # Home directory configurations
├── modules/               # Custom NixOS modules
│   ├── desktop/           # Desktop environment configurations
│   ├── hardware/          # Hardware-specific modules
│   ├── programs/          # Program-specific configurations
│   ├── services/          # System services
│   ├── system/            # Core system modules
│   └── users/             # User-specific configurations
├── packages/              # Custom packages
└── README.md              # This file
```

## Features

### Desktop Environment
- **Hyprland**: Tiling Wayland compositor with custom animations, keybindings, and workspace management
- **[Caelestia Shell](https://github.com/caelestia-dots/shell)**: Enhanced shell experience for Hyprland (themes, widgets, utilities)
- **KDE Plasma**: Full-featured desktop environment as stable backup
- **SDDM**: Display manager with theme customization
- **Starship Prompt**: Cross-shell prompt with rich customization
- **Font Collection**: Custom curated fonts for optimal readability

### Development Environment
- **.NET SDK**: Complete development kit for .NET applications
- **Java**: OpenJDK development environment
- **Node.js & Bun**: JavaScript/TypeScript runtimes
- **PostgreSQL**: Robust relational database service
- **Development Tools**: Essential CLI tools, editors, and utilities
- **Compatibility Layer**: `nix-ld` for running unpatched non-Nix binaries
- **Container Support**: Docker and podman integration (via modules)

### System Resilience & Security
- **Btrfs**: Advanced filesystem with compression and deduplication
- **Snapper**: Automated snapshot management for easy rollback
- **Secure Boot**: Full support via Lanzaboote with PKI management
- **Boot Experience**: Plymouth boot animation with custom themes
- **Filesystem Optimizations**: `noatime`, `zstd` compression, automatic scrubbing
- **Backup Strategies**: Manual and automated snapshot workflows

### System Services
- **Audio**: PipeWire with PulseAudio and JACK compatibility
- **Bluetooth**: Full stack with GUI management tools
- **Printing**: CUPS with driverless printing support
- **Networking**: NetworkManager (alternatives available via modules)
- **VPN**: Warp client for secure connectivity
- **Flatpak & AppImage**: Universal Linux package support

### User Environment (Home Manager)
- **Shell**: Zsh with plugins, completions, and custom configuration
- **Git**: Configured with aliases, hooks, and credential helpers
- **CLI Tools**: Enhanced versions of common utilities (e.g., eza, bat, fd, ripgrep)
- **Applications**: Pre-configured settings for frequently used GUI applications
- **Customization**: Themes, icons, cursor, and desktop effects

## Installation

1. **Clone the repository**:
   ```bash
   git clone <https://github.com/Theneillsaaco/nixos> /etc/nixos
   cd /etc/nixos
   ```

2. **Prepare host configuration**:
   ```bash
   # Create directory for your hostname
   mkdir -p hosts/<your-hostname>
   
   # Copy hardware configuration (generated during installation)
   cp /etc/nixos/hardware-configuration.nix hosts/<your-hostname>/
   ```

3. **Build and switch to the configuration**:
   ```bash
   sudo nixos-rebuild switch --flake .#nixosConfigurations.nixos
   ```

4. **Initial setup notes**:
   - For first-time installation, you may need to configure hardware-specific settings first
   - The system will use the laptop configuration by default; adjust as needed for other hardware
   - Enable services incrementally to ensure compatibility with your specific setup

## Configuration

### Host-Specific Settings
Laptop-specific configurations are in `hosts/laptop/` including:
- `configuration.nix`: Main system configuration (services, settings, etc.)
- `hardware-configuration.nix`: Auto-generated hardware detection (do not edit manually)

### User Settings
User-specific configurations managed by Home Manager are in:
- `home/isaac.nix`: Main Home Manager configuration (modules, packages, settings)
- `home/isaac/programs/`: Program-specific configurations (CLI tools, GUI apps)
- `modules/users/isaac.nix`: NixOS user account and security settings

### Modules Organization
Custom NixOS modules are organized by concern:
- **System**: Boot, networking, locale, time, security, logging
- **Desktop**: Window managers, display managers, desktop environments
- **Hardware**: Platform-specific optimizations and drivers
- **Services**: Daemons and network services (audio, bluetooth, printing, etc.)
- **Programs**: Development tools, applications, and utilities
- **Users**: Account definitions, permissions, and environmental variables

## Custom Packages

Located in the `packages/` directory:
- `base.nix`: Essential system packages and utilities
- `fonts.nix`: Custom font collection with installation scripts

## Maintenance

### Regular Updates
```bash
# Update all flake inputs to latest versions
nix flake update

# Rebuild system with updated packages
sudo nixos-rebuild switch --flake .#nixosConfigurations.nixos

# Update user environment
home-manager switch --flake .#isaac
```

### Garbage Collection
```bash
# Remove old generations (keep last 2)
sudo nix-collect-garbage -d

# Optimize Nix store
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

## License

See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- NixOS community for the incredible ecosystem
- Caelestia-dots team for the beautiful shell themes
- Hyprland developers for the innovative Wayland compositor
- All contributors to the open-source software used in this configuration