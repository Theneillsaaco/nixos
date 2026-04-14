# Isaac's NixOS Configuration

This is my personal NixOS configuration using the Nix package manager. It's designed for a laptop setup with Hyprland as the primary desktop environment and Plasma as a backup.

## System Overview

- **Base System**: NixOS unstable channel
- **Desktop Environment**: Hyprland (Wayland compositor)
- **Additional Services**: Bluetooth, Audio (PipeWire), Printing, Keyring, Btrfs, Warp
- **Development Tools**: .Net, Java, Postgres, DevTools, Nix-LD
- **User Configuration**: Managed with Home Manager

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

### Desktop Environment
- Hyprland with custom animations and keybindings (primary)
- Plasma desktop (backup)
- SDDM display manager
- Starship prompt for enhanced terminal experience

### System Services
- Bluetooth support
- Audio via PipeWire
- Printing services
- Keyring management (KDE Wallet)
- Btrfs filesystem tools
- Warp VPN client
- Flatpak and AppImage support

### Development Environment
- .NET SDK
- Java development environment
- PostgreSQL database
- Essential development tools
- Nix-LD for running non-Nix binaries
- Custom font collection

### User Configuration (Home Manager)
- Zsh shell with custom configuration
- Git configuration
- Development tools (editors, terminals, etc.)
- Application preferences

## Installation

1. Clone this repository to `/etc/nixos`
2. Run `nixos-rebuild switch --flake .#nixosConfigurations.nixos`
3. For initial installation, you may need to configure hardware-specific settings first

## Configuration

### Host-Specific Settings
Laptop-specific configurations are in `hosts/laptop/` including:
- `configuration.nix`: Main system configuration
- `hardware-configuration.nix`: Hardware detection results

### User Settings
User-specific configurations managed by Home Manager are in:
- `home/isaac.nix`: Main Home Manager configuration
- `home/programs/`: Program-specific configurations
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