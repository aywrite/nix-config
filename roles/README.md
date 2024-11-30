# Roles

This directory contains role-based configurations that combine various programs and settings for specific use cases.

## Available Roles

### xmonad-laptop.nix
A configuration for laptops using XMonad as the window manager.

**Features:**
- XMonad window manager with custom configuration
- Status bar with system information
- Power management settings
- Laptop-specific optimizations
- Development tools

### sway-laptop.nix
A Wayland-based configuration using Sway.

**Features:**
- Sway window manager
- Waybar status bar
- Native Wayland applications
- HiDPI support
- Modern system notifications

### i3-laptop.nix
A configuration using i3 window manager.

**Features:**
- i3 window manager
- i3status bar
- X11 configuration
- Standard development tools

### darwin-laptop.nix
Configuration for macOS systems.

**Features:**
- macOS-specific optimizations
- Terminal configuration
- Development environment
- Cross-platform compatibility

## Creating a New Role

1. Create a new .nix file in this directory
2. Import necessary program configurations
3. Configure role-specific settings
4. Add documentation in this README

Example structure for a new role:
```nix
{ config, pkgs, ... }:

{
  imports = [
    ../programs/core-programs.nix
    ../programs/development.nix
    # Add other necessary imports
  ];

  # Role-specific configurations
  programs.specific-program = {
    enable = true;
    # Additional settings
  };

  # System settings
  services.some-service = {
    enable = true;
    # Service configuration
  };
}
```

## Best Practices

1. Keep roles focused and purpose-specific
2. Document role requirements and features
3. Consider hardware compatibility
4. Include necessary program imports
5. Configure reasonable defaults
6. Add comments for complex configurations
